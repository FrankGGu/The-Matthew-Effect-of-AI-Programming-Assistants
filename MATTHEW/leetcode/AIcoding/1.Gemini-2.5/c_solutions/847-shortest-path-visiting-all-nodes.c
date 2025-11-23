#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int node;
    int mask;
    int dist;
} State;

#define MAX_QUEUE_SIZE (12 * (1 << 12))

State queue[MAX_QUEUE_SIZE];
int front = 0;
int rear = 0;

void enqueue(State s) {
    queue[rear++] = s;
}

State dequeue() {
    return queue[front++];
}

bool is_empty() {
    return front == rear;
}

bool visited[12][1 << 12];

int shortestPathLength(int** graph, int graphSize, int* graphColSize) {
    int n = graphSize;

    // If there's only one node, the path length is 0.
    if (n == 1) {
        return 0;
    }

    // The target mask where all bits are set, indicating all nodes have been visited.
    int all_visited_mask = (1 << n) - 1;

    // Reset queue pointers for each test case
    front = 0;
    rear = 0;

    // Reset the visited array for each test case
    // sizeof(visited) calculates the total size in bytes for the 2D array
    memset(visited, 0, sizeof(visited));

    // Initialize BFS: Start from each node, with only that node visited.
    for (int i = 0; i < n; i++) {
        State initial_state = {i, (1 << i), 0};
        enqueue(initial_state);
        visited[i][(1 << i)] = true;
    }

    // Perform BFS
    while (!is_empty()) {
        State current = dequeue();

        // If all nodes have been visited, we found the shortest path.
        if (current.mask == all_visited_mask) {
            return current.dist;
        }

        // Explore neighbors of the current node
        for (int i = 0; i < graphColSize[current.node]; i++) {
            int neighbor = graph[current.node][i];

            // Calculate the new mask by adding the neighbor to the visited set
            int new_mask = current.mask | (1 << neighbor);

            // If this (neighbor, new_mask) state has not been visited before
            if (!visited[neighbor][new_mask]) {
                visited[neighbor][new_mask] = true;
                State next_state = {neighbor, new_mask, current.dist + 1};
                enqueue(next_state);
            }
        }
    }

    // This part should ideally not be reached given the problem constraints
    // (graph is connected and a path always exists).
    return -1; 
}