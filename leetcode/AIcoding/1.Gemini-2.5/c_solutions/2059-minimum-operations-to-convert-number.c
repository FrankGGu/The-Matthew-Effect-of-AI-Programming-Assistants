#include <stdbool.h>
#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

#define MIN_VAL_TRACKED -1000
#define MAX_VAL_TRACKED 4000
#define OFFSET (0 - MIN_VAL_TRACKED) // = 1000
#define VISITED_ARRAY_SIZE (MAX_VAL_TRACKED - MIN_VAL_TRACKED + 1) // = 4000 - (-1000) + 1 = 5001

typedef struct {
    int val;
    int steps;
} QueueNode;

#define MAX_QUEUE_CAPACITY (VISITED_ARRAY_SIZE * 2)

int minOperations(int* nums, int numsSize, int start, int target) {
    if (start == target) {
        return 0;
    }

    // visited array to store minimum steps to reach a number
    // Initialize with -1 to indicate not visited
    int* visited = (int*)malloc(VISITED_ARRAY_SIZE * sizeof(int));
    if (visited == NULL) {
        return -1; // Memory allocation failed
    }
    // Using memset for efficiency to initialize all elements to -1
    // (Note: -1 in two's complement is all bits set, which works for int)
    memset(visited, -1, VISITED_ARRAY_SIZE * sizeof(int));

    // Queue for BFS
    QueueNode* queue = (QueueNode*)malloc(MAX_QUEUE_CAPACITY * sizeof(QueueNode));
    if (queue == NULL) {
        free(visited);
        return -1; // Memory allocation failed
    }
    int head = 0;
    int tail = 0;

    // Add start node to queue
    queue[tail++] = (QueueNode){.val = start, .steps = 0};

    // Mark start as visited (start is guaranteed to be within 0-1000, so within tracked range)
    visited[start + OFFSET] = 0;

    while (head < tail) {
        QueueNode current = queue[head++];

        // Explore neighbors
        for (int i = 0; i < numsSize; ++i) {
            int num_val = nums[i];

            // Operation 1: x + num
            int next_val_add = current.val + num_val;
            if (next_val_add == target) {
                free(visited);
                free(queue);
                return current.steps + 1;
            }
            // Check if next_val_add is within our tracking range and not visited
            if (next_val_add >= MIN_VAL_TRACKED && next_val_add <= MAX_VAL_TRACKED) {
                if (visited[next_val_add + OFFSET] == -1) {
                    visited[next_val_add + OFFSET] = current.steps + 1;
                    queue[tail++] = (QueueNode){.val = next_val_add, .steps = current.steps + 1};
                }
            }

            // Operation 2: x - num
            int next_val_sub = current.val - num_val;
            if (next_val_sub == target) {
                free(visited);
                free(queue);
                return current.steps + 1;
            }
            if (next_val_sub >= MIN_VAL_TRACKED && next_val_sub <= MAX_VAL_TRACKED) {
                if (visited[next_val_sub + OFFSET] == -1) {
                    visited[next_val_sub + OFFSET] = current.steps + 1;
                    queue[tail++] = (QueueNode){.val = next_val_sub, .steps = current.steps + 1};
                }
            }

            // Operation 3: x ^ num
            int next_val_xor = current.val ^ num_val;
            if (next_val_xor == target) {
                free(visited);
                free(queue);
                return current.steps + 1;
            }
            if (next_val_xor >= MIN_VAL_TRACKED && next_val_xor <= MAX_VAL_TRACKED) {
                if (visited[next_val_xor + OFFSET] == -1) {
                    visited[next_val_xor + OFFSET] = current.steps + 1;
                    queue[tail++] = (QueueNode){.val = next_val_xor, .steps = current.steps + 1};
                }
            }
        }
    }

    // If the queue becomes empty and target was not reached
    free(visited);
    free(queue);
    return -1; // Target not reachable
}