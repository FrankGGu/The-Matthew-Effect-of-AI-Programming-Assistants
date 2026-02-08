#include <stdlib.h> // For qsort, bsearch
#include <math.h>   // For fmax, though direct comparison is used for long long

int compareLongLong(const void *a, const void *b) {
    long long val_a = *(const long long *)a;
    long long val_b = *(const long long *)b;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

long long robotSim(int* commands, int commandsSize, int** obstacles, int obstaclesSize, int* obstaclesColSize) {
    // dx and dy arrays for directions: North, East, South, West
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};

    int current_x = 0;
    int current_y = 0;
    int current_dir = 0; // 0: North, 1: East, 2: South, 3: West

    long long max_dist_sq = 0LL;

    // Prepare obstacle keys for efficient lookup using binary search
    long long* obstacle_keys = NULL;
    if (obstaclesSize > 0) {
        obstacle_keys = (long long*)malloc(sizeof(long long) * obstaclesSize);
        for (int i = 0; i < obstaclesSize; ++i) {
            // Map coordinates [-30000, 30000] to [0, 60000]
            // Create a unique long long key for each (x, y) pair
            // Multiplier 60001 ensures uniqueness as max y_mapped is 60000
            obstacle_keys[i] = (long long)(obstacles[i][0] + 30000) * 60001 + (obstacles[i][1] + 30000);
        }
        qsort(obstacle_keys, obstaclesSize, sizeof(long long), compareLongLong);
    }

    for (int c = 0; c < commandsSize; ++c) {
        int command = commands[c];

        if (command == -2) { // Turn left 90 degrees
            current_dir = (current_dir + 3) % 4;
        } else if (command == -1) { // Turn right 90 degrees
            current_dir = (current_dir + 1) % 4;
        } else { // Move forward 'command' units
            for (int i = 0; i < command; ++i) {
                int next_x = current_x + dx[current_dir];
                int next_y = current_y + dy[current_dir];

                long long next_key = (long long)(next_x + 30000) * 60001 + (next_y + 30000);

                // Check if the next position is an obstacle
                if (obstacle_keys != NULL && bsearch(&next_key, obstacle_keys, obstaclesSize, sizeof(long long), compareLongLong) != NULL) {
                    // Obstacle found, robot stops moving for this command
                    break;
                } else {
                    // No obstacle, update robot's position
                    current_x = next_x;
                    current_y = next_y;

                    // Update maximum squared Euclidean distance
                    long long current_dist_sq = (long long)current_x * current_x + (long long)current_y * current_y;
                    if (current_dist_sq > max_dist_sq) {
                        max_dist_sq = current_dist_sq;
                    }
                }
            }
        }
    }

    if (obstacle_keys != NULL) {
        free(obstacle_keys);
    }

    return max_dist_sq;
}