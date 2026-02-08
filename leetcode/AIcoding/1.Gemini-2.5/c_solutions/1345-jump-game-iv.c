#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

typedef struct {
    int* data;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

void initQueue(Queue* q, int capacity) {
    q->data = (int*)malloc(sizeof(int) * capacity);
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = capacity;
}

void enqueue(Queue* q, int val) {
    if (q->size == q->capacity) {
        // This case should ideally not be hit if capacity is correctly sized (e.g., arrSize)
        return; 
    }
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = val;
    q->size++;
}

int dequeue(Queue* q) {
    if (q->size == 0) {
        return -1; // Should not happen in a correctly implemented BFS
    }
    int val = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return val;
}

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    q->data = NULL;
}

typedef struct {
    int val;
    int idx;
} ValIdx;

int compareValIdx(const void* a, const void* b) {
    return ((ValIdx*)a)->val - ((ValIdx*)b)->val;
}

typedef struct {
    int val;
    int start_idx; // Start index in the sorted ValIdx array
    int end_idx;   // End index (exclusive) in the sorted ValIdx array
    bool processed; // Flag to indicate if this group has been processed for same-value jumps
} GroupInfo;

int compareGroupInfo(const void* key, const void* elem) {
    return *(int*)key - ((GroupInfo*)elem)->val;
}

int jump(int* arr, int arrSize) {
    if (arrSize == 1) {
        return 0;
    }

    // 1. Pre-process to create the value-to-indices map
    ValIdx* val_idx_pairs = (ValIdx*)malloc(arrSize * sizeof(ValIdx));
    for (int i = 0; i < arrSize; ++i) {
        val_idx_pairs[i].val = arr[i];
        val_idx_pairs[i].idx = i;
    }

    qsort(val_idx_pairs, arrSize, sizeof(ValIdx), compareValIdx);

    // Build GroupInfo array
    // Max possible unique values is arrSize
    GroupInfo* group_infos = (GroupInfo*)malloc(arrSize * sizeof(GroupInfo));
    int num_unique_values = 0;

    if (arrSize > 0) {
        group_infos[0].val = val_idx_pairs[0].val;
        group_infos[0].start_idx = 0;
        group_infos[0].processed = false;
        num_unique_values = 1;

        for (int i = 1; i < arrSize; ++i) {
            if (val_idx_pairs[i].val != val_idx_pairs[i-1].val) {
                group_infos[num_unique_values-1].end_idx = i; // Close previous group

                group_infos[num_unique_values].val = val_idx_pairs[i].val;
                group_infos[num_unique_values].start_idx = i;
                group_infos[num_unique_values].processed = false;
                num_unique_values++;
            }
        }
        group_infos[num_unique_values-1].end_idx = arrSize; // Close last group
    }

    // 2. BFS
    Queue q;
    initQueue(&q, arrSize);

    bool* visited = (bool*)calloc(arrSize, sizeof(bool)); // Initialize all to false

    enqueue(&q, 0);
    visited[0] = true;
    int steps = 0;

    while (!isEmpty(&q)) {
        int level_size = q.size;
        for (int i = 0; i < level_size; ++i) {
            int curr_idx = dequeue(&q);

            if (curr_idx == arrSize - 1) {
                freeQueue(&q);
                free(visited);
                free(val_idx_pairs);
                free(group_infos);
                return steps;
            }

            // Jump to curr_idx + 1
            if (curr_idx + 1 < arrSize && !visited[curr_idx + 1]) {
                enqueue(&q, curr_idx + 1);
                visited[curr_idx + 1] = true;
            }

            // Jump to curr_idx - 1
            if (curr_idx - 1 >= 0 && !visited[curr_idx - 1]) {
                enqueue(&q, curr_idx - 1);
                visited[curr_idx - 1] = true;
            }

            // Jump to indices with the same value
            // Find the group info for arr[curr_idx]
            GroupInfo* target_group = (GroupInfo*)bsearch(&(arr[curr_idx]), group_infos, num_unique_values, sizeof(GroupInfo), compareGroupInfo);

            if (target_group != NULL && !target_group->processed) {
                for (int j = target_group->start_idx; j < target_group->end_idx; ++j) {
                    int neighbor_idx = val_idx_pairs[j].idx;
                    if (!visited[neighbor_idx]) {
                        enqueue(&q, neighbor_idx);
                        visited[neighbor_idx] = true;
                    }
                }
                target_group->processed = true; // Mark this group as processed
            }
        }
        steps++;
    }

    // Should not reach here for valid problem inputs where a path always exists
    freeQueue(&q);
    free(visited);
    free(val_idx_pairs);
    free(group_infos);
    return -1; // No path found
}