#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For qsort

typedef struct {
    int* data;
    int size;
    int capacity;
} IntVector;

void initVector(IntVector* vec, int initialCapacity) {
    vec->data = (int*)malloc(sizeof(int) * initialCapacity);
    vec->size = 0;
    vec->capacity = initialCapacity;
}

void addVector(IntVector* vec, int val) {
    if (vec->size == vec->capacity) {
        vec->capacity *= 2;
        if (vec->capacity == 0) vec->capacity = 1; // Handle initial capacity of 0, if any
        vec->data = (int*)realloc(vec->data, sizeof(int) * vec->capacity);
    }
    vec->data[vec->size++] = val;
}

void freeVector(IntVector* vec) {
    if (vec->data) {
        free(vec->data);
        vec->data = NULL;
    }
    vec->size = 0;
    vec->capacity = 0;
}

typedef struct {
    int* data;
    int head;
    int tail;
    int capacity;
} IntQueue;

void initQueue(IntQueue* q, int capacity) {
    q->data = (int*)malloc(sizeof(int) * capacity);
    q->head = 0;
    q->tail = 0;
    q->capacity = capacity;
}

void enqueue(IntQueue* q, int val) {
    q->data[q->tail++] = val;
}

int dequeue(IntQueue* q) {
    return q->data[q->head++];
}

bool isQueueEmpty(IntQueue* q) {
    return q->head == q->tail;
}

void freeQueue(IntQueue* q) {
    if (q->data) {
        free(q->data);
        q->data = NULL;
    }
    q->head = 0;
    q->tail = 0;
    q->capacity = 0;
}

int compareInt(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

IntVector* topologicalSort(int num_nodes, IntVector* adj, int* in_degree, int* result_size) {
    IntQueue q;
    initQueue(&q, num_nodes + 1);

    IntVector* result_vec = (IntVector*)malloc(sizeof(IntVector));
    initVector(result_vec, num_nodes > 0 ? num_nodes : 1); // Ensure initial capacity is at least 1

    for (int i = 0; i < num_nodes; ++i) {
        if (in_degree[i] == 0) {
            enqueue(&q, i);
        }
    }

    while (!isQueueEmpty(&q)) {
        int u = dequeue(&q);
        addVector(result_vec, u);

        for (int i = 0; i < adj[u].size; ++i) {
            int v = adj[u].data[i];
            in_degree[v]--;
            if (in_degree[v] == 0) {
                enqueue(&q, v);
            }
        }
    }

    freeQueue(&q);

    if (result_vec->size != num_nodes) {
        freeVector(result_vec);
        free(result_vec);
        *result_size = 0;
        return NULL; // Cycle detected
    }
    *result_size = result_vec->size;
    return result_vec;
}

int* assignItemsToGroups(int n, int m, int* group, int groupSize, int** beforeItems, int* beforeItemsColSize, int* returnSize) {
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }

    // 1. Pre-process groups: Assign unique group IDs to unassigned items
    int k_new = groupSize;
    int* effective_group = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; ++i) {
        if (group[i] == -1) {
            effective_group[i] = k_new++;
        } else {
            effective_group[i] = group[i];
        }
    }

    // Initialize adjacency lists and in-degrees
    IntVector* adj_item = (IntVector*)malloc(sizeof(IntVector) * n);
    int* in_degree_item = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; ++i) {
        initVector(&adj_item[i], 4);
    }

    IntVector* adj_group_temp = (IntVector*)malloc(sizeof(IntVector) * k_new);
    for (int i = 0; i < k_new; ++i) {
        initVector(&adj_group_temp[i], 4);
    }

    // 2. Build graphs
    for (int curr_item = 0; curr_item < n; ++curr_item) {
        for (int j = 0; j < beforeItemsColSize[curr_item]; ++j) {
            int prev_item = beforeItems[curr_item][j];

            // Item dependency graph
            addVector(&adj_item[prev_item], curr_item); // prev_item -> curr_item
            in_degree_item[curr_item]++;

            // Group dependency graph
            if (effective_group[prev_item] != effective_group[curr_item]) {
                addVector(&adj_group_temp[effective_group[prev_item]], effective_group[curr_item]);
            }
        }
    }

    // Process adj_group_temp to create unique adj_group and in_degree_group
    IntVector* adj_group = (IntVector*)malloc(sizeof(IntVector) * k_new);
    int* in_degree_group = (int*)calloc(k_new, sizeof(int));
    for (int i = 0; i < k_new; ++i) {
        initVector(&adj_group[i], 4);
        if (adj_group_temp[i].size > 0) {
            qsort(adj_group_temp[i].data, adj_group_temp[i].size, sizeof(int), compareInt);
            addVector(&adj_group[i], adj_group_temp[i].data[0]);
            in_degree_group[adj_group_temp[i].data[0]]++;
            for (int j = 1; j < adj_group_temp[i].size; ++j) {
                if (adj_group_temp[i].data[j] != adj_group_temp[i].data[j-1]) {
                    addVector(&adj_group[i], adj_group_temp[i].data[j]);
                    in_degree_group[adj_group_temp[i].data[j]]++;
                }
            }
        }
        freeVector(&adj_group_temp[i]);
    }
    free(adj_group_temp);

    // 3. Topological sort for items
    int item_topo_size;
    IntVector* item_topo_order = topologicalSort(n, adj_item, in_degree_item, &item_topo_size);
    if (item_topo_order == NULL) {
        *returnSize = 0;
        for (int i = 0; i < n; ++i) freeVector(&adj_item[i]);
        free(adj_item);
        free(in_degree_item);
        for (int i = 0; i < k_new; ++i) freeVector(&adj_group[i]);
        free(adj_group);
        free(in_degree_group);
        free(effective_group);
        return NULL;
    }

    // 4. Topological sort for groups
    int group_topo_size;
    IntVector* group_topo_order = topologicalSort(k_new, adj_group, in_degree_group, &group_topo_size);
    if (group_topo_order == NULL) {
        *returnSize = 0;
        for (int i = 0; i < n; ++i) freeVector(&adj_item[i]);
        free(adj_item);
        free(in_degree_item);
        freeVector(item_topo_order);
        free(item_topo_order);
        for (int i = 0; i < k_new; ++i) freeVector(&adj_group[i]);
        free(adj_group);
        free(in_degree_group);
        free(effective_group);
        return NULL;
    }

    // 5. Combine results
    IntVector* items_in_group = (IntVector*)malloc(sizeof(IntVector) * k_new);
    for (int i = 0; i < k_new; ++i) {
        initVector(&items_in_group[i], 4);
    }

    for (int i = 0; i < item_topo_order->size; ++i) {
        int item = item_topo_order->data[i];
        addVector(&items_in_group[effective_group[item]], item);
    }

    int* final_result = (int*)malloc(sizeof(int) * n);
    int current_idx = 0;
    for (int i = 0; i < group_topo_order->size; ++i) {
        int g = group_topo_order->data[i];
        for (int j = 0; j < items_in_group[g].size; ++j) {
            final_result[current_idx++] = items_in_group[g].data[j];
        }
    }
    *returnSize = n;

    // Free all allocated memory
    for (int i = 0; i < n; ++i) freeVector(&adj_item[i]);
    free(adj_item);
    free(in_degree_item);
    freeVector(item_topo_order);
    free(item_topo_order);
    for (int i = 0; i < k_new; ++i) freeVector(&adj_group[i]);
    free(adj_group);
    free(in_degree_group);
    freeVector(group_topo_order);
    free(group_topo_order);
    for (int i = 0; i < k_new; ++i) freeVector(&items_in_group[i]);
    free(items_in_group);
    free(effective_group);

    return final_result;
}