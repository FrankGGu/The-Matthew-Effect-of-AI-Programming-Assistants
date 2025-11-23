#include <stdbool.h>
#include <stdlib.h> // For malloc, calloc, free

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumDetonation(int** bombs, int bombsSize, int* bombsColSize) {
    if (bombsSize == 0) {
        return 0;
    }

    int maxDetonated = 0;

    // Iterate through each bomb, considering it as a potential starting point
    for (int i = 0; i < bombsSize; ++i) {
        // Initialize visited array and queue for the current BFS traversal
        bool* visited = (bool*)calloc(bombsSize, sizeof(bool)); // calloc initializes to false
        int* queue = (int*)malloc(bombsSize * sizeof(int));
        int front = 0;
        int rear = 0;
        int currentDetonatedCount = 0;

        // Start BFS from bomb 'i'
        queue[rear++] = i;
        visited[i] = true;
        currentDetonatedCount++;

        while (front < rear) {
            int currentBombIdx = queue[front++];

            // Check all other bombs to see if they are detonated by the current bomb
            for (int j = 0; j < bombsSize; ++j) {
                if (!visited[j]) {
                    // Coordinates and radius of the current bomb
                    long long x1 = bombs[currentBombIdx][0];
                    long long y1 = bombs[currentBombIdx][1];
                    long long r1 = bombs[currentBombIdx][2];

                    // Coordinates of bomb 'j'
                    long long x2 = bombs[j][0];
                    long long y2 = bombs[j][1];

                    // Calculate squared distance between bomb 'currentBombIdx' and bomb 'j'
                    long long dx = x2 - x1;
                    long long dy = y2 - y1;
                    long long distSq = dx * dx + dy * dy;

                    // Calculate squared radius of bomb 'currentBombIdx'
                    long long radiusSq = r1 * r1;

                    // If bomb 'j' is within the explosion radius of 'currentBombIdx'
                    if (distSq <= radiusSq) {
                        visited[j] = true;
                        queue[rear++] = j;
                        currentDetonatedCount++;
                    }
                }
            }
        }

        // Update the maximum number of bombs detonated
        maxDetonated = max(maxDetonated, currentDetonatedCount);

        // Free memory allocated for the current BFS traversal
        free(visited);
        free(queue);
    }

    return maxDetonated;
}