#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} DynamicArray;

void initDynamicArray(DynamicArray* arr, int initialCapacity) {
    if (initialCapacity == 0) initialCapacity = 1;
    arr->data = (int*)malloc(sizeof(int) * initialCapacity);
    arr->size = 0;
    arr->capacity = initialCapacity;
}

void addDynamicArray(DynamicArray* arr, int item) {
    if (arr->size == arr->capacity) {
        arr->capacity *= 2;
        arr->data = (int*)realloc(arr->data, sizeof(int) * arr->capacity);
    }
    arr->data[arr->size++] = item;
}

void freeDynamicArray(DynamicArray* arr) {
    if (arr && arr->data) {
        free(arr->data);
    }
    if (arr) {
        arr->data = NULL;
        arr->size = 0;
        arr->capacity = 0;
    }
}

typedef struct {
    int* arr;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    if (!q) return NULL;
    q->capacity = capacity;
    q->arr = (int*)malloc(sizeof(int) * capacity);
    if (!q->arr) {
        free(q);
        return NULL;
    }
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int item) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->arr[q->rear] = item;
    q->size++;
}

int dequeue(Queue* q) {
    if (q->size == 0) return -1;
    int item = q->arr[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return item;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    if (q) {
        if (q->arr) free(q->arr);
        free(q);
    }
}

typedef struct {
    int u;
    int v;
} GroupDep;

int compareGroupDeps(const void* a, const void* b) {
    GroupDep* depA = (GroupDep*)a;
    GroupDep* depB = (GroupDep*)b;
    if (depA->u != depB->u) {
        return depA->u - depB->u;
    }
    return depA->v - depB->v;
}

void freeAll(DynamicArray* group_adj_da, int total_groups, int* group_indegree,
             DynamicArray* item_adj_in_group_da, int n, int* item_indegree,
             DynamicArray* items_in_group_list_da,
             DynamicArray* sorted_items_in_group_da,
             GroupDep* group_deps_raw_data,
             DynamicArray* group_order_da_ptr,
             int* group_map_ptr, Queue* q1, Queue* q2) {

    if (group_adj_da) {
        for (int i = 0; i < total_groups; i++) {
            freeDynamicArray(&group_adj_da[i]);
        }
        free(group_adj_da);
    }
    if (group_indegree) free(group_indegree);

    if (item_adj_in_group_da) {
        for (int i = 0; i < n; i++) {
            freeDynamicArray(&item_adj_in_group_da[i]);
        }
        free(item_adj_in_group_da);
    }
    if (item_indegree) free(item_indegree);

    if (items_in_group_list_da) {
        for (int i = 0; i < total_groups; i++) {
            freeDynamicArray(&items_in_group_list_da[i]);
        }
        free(items_in_group_list_da);
    }

    if (sorted_items_in_group_da) {
        for (int i = 0; i < total_groups; i++) {
            freeDynamicArray(&sorted_items_in_group_da[i]);
        }
        free(sorted_items_in_group_da);
    }

    if (group_deps_raw_data) free(group_deps_raw_data);
    if (group_order_da_ptr) freeDynamicArray(group_order_da_ptr);
    if (group_map_ptr) free(group_map_ptr);
    if (q1) freeQueue(q1);
    if (q2) freeQueue(q2);
}

int* sortItems(int n, int m, int* group, int groupSize, int** beforeItems, int* beforeItemsColSize, int beforeItemsSize, int* returnSize) {
    // 1. Assign new group IDs to items not in any group
    int* group_map = (int*)malloc(n * sizeof(int));
    if (!group_map) { *returnSize = 0; return NULL; }

    int current_group_id = m;
    for (int i = 0; i < n; i++) {
        if (group[i] == -1) {
            group_map[i] = current_group_id++;
        } else {
            group_map[i] = group[i];
        }
    }
    int total_effective_groups = current_group_id;

    // Calculate total number of dependencies for raw group_deps_raw_data allocation
    int D_total = 0;
    for(int i = 0; i < n; ++i) {
        D_total += beforeItemsColSize[i];
    }

    // Allocate memory for data structures
    DynamicArray* group_adj_da = (DynamicArray*)malloc(total_effective_groups * sizeof(DynamicArray));
    int* group_indegree = (int*)calloc(total_effective_groups, sizeof(int));
    GroupDep* group_deps_raw_data = (GroupDep*)malloc(D_total * sizeof(GroupDep));
    if (!group_adj_da || !group_indegree || (D_total > 0 && !group_deps_raw_data)) {
        freeAll(group_adj_da, total_effective_groups, group_indegree, NULL, 0, NULL, NULL, NULL, group_deps_raw_data, NULL, group_map, NULL, NULL);
        *returnSize = 0; return NULL;
    }
    for (int i = 0; i < total_effective_groups; i++) {
        initDynamicArray(&group_adj_da[i], 4);
    }
    int group_deps_raw_size = 0;

    DynamicArray* item_adj_in_group_da = (DynamicArray*)malloc(n * sizeof(DynamicArray));
    int* item_indegree = (int*)calloc(n, sizeof(int));
    if (!item_adj_in_group_da || !item_indegree) {
        freeAll(group_adj_da, total_effective_groups, group_indegree, item_adj_in_group_da, n, item_indegree, NULL, NULL, group_deps_raw_data, NULL, group_map, NULL, NULL);
        *returnSize = 0; return NULL;
    }
    for (int i = 0; i < n; i++) {
        initDynamicArray(&item_adj_in_group_da[i], 4);
    }

    DynamicArray* items_in_group_list_da = (DynamicArray*)malloc(total_effective_groups * sizeof(DynamicArray));
    if (!items_in_group_list_da) {
        freeAll(group_adj_da, total_effective_groups, group_indegree, item_adj_in_group_da, n, item_indegree, items_in_group_list_da, NULL, group_deps_raw_data, NULL, group_map, NULL, NULL);
        *returnSize = 0; return NULL;
    }
    for (int i = 0; i < total_effective_groups; i++) {
        initDynamicArray(&items_in_group_list_da[i], 4);
    }

    // 2. Build item graph (within groups) and collect raw group dependencies
    for (int i = 0; i < n; i++) {
        addDynamicArray(&items_in_group_list_da[group_map[i]], i);
        for (int j = 0; j < beforeItemsColSize[i]; j++) {
            int prev_item = beforeItems[i][j];
            if (group_map[prev_item] == group_map[i]) {
                addDynamicArray(&item_adj_in_group_da[prev_item], i);
                item_indegree[i]++;
            } else {
                group_deps_raw_data[group_deps_raw_size].u = group_map[prev_item];
                group_deps_raw_data[group_deps_raw_size].v = group_map[i];
                group_deps_raw_size++;
            }
        }
    }

    // 3. Process raw group dependencies to build unique group graph
    qsort(group_deps_raw_data, group_deps_raw_size, sizeof(GroupDep), compareGroupDeps);

    if (group_deps_raw_size > 0) {
        addDynamicArray(&group_adj_da[group_deps_raw_data[0].u], group_deps_raw_data[0].v);
        group_indegree[group_deps_raw_data[0].v]++;
        for (int i = 1; i < group_deps_raw_size; i++) {
            if (group_deps_raw_data[i].u != group_deps_raw_data[i-1].u ||
                group_deps_raw_data[i].v != group_deps_raw_data[i-1].v) {
                addDynamicArray(&group_adj_da[group_deps_raw_data[i].u], group_deps_raw_data[i].v);
                group_indegree[group_deps_raw_data[i].v]++;
            }
        }
    }
    free(group_deps_raw_data);
    group_deps_raw_data = NULL; // Mark as freed

    // 4. Topological sort for groups
    Queue* q_groups = createQueue(total_effective_groups);
    if (!q_groups) {
        freeAll(group_adj_da, total_effective_groups, group_indegree, item_adj_in_group_da, n, item_indegree, items_in_group_list_da, NULL, group_deps_raw_data, NULL, group_map, NULL, NULL);
        *returnSize = 0; return NULL;
    }

    DynamicArray group_order_da;
    initDynamicArray(&group_order_da, total_effective_groups);

    for (int i = 0; i < total_effective_groups; i++) {
        if (group_indegree[i] == 0) {
            enqueue(q_groups, i);
        }
    }

    int groups_sorted_count = 0;
    while (!isEmpty(q_groups)) {
        int u_group = dequeue(q_groups);
        addDynamicArray(&group_order_da, u_group);
        groups_sorted_count++;

        for (int i = 0; i < group_adj_da[u_group].size; i++) {
            int v_group = group_adj_da[u_group].data[i];
            group_indegree[v_group]--;
            if (group_indegree[v_group] == 0) {
                enqueue(q_groups, v_group);
            }
        }
    }
    freeQueue(q_groups);

    if (groups_sorted_count != total_effective_groups) {
        freeAll(group_adj_da, total_effective_groups, group_indegree, item_adj_in_group_da, n, item_indegree, items_in_group_list_da, NULL, group_deps_raw_data, &group_order_da, group_map, NULL, NULL);
        *returnSize = 0; return NULL;
    }

    // 5. Topological sort for items within each group
    DynamicArray* sorted_items_in_group_da = (DynamicArray*)malloc(total_effective_groups * sizeof(DynamicArray));
    if (!sorted_items_in_group_da) {
        freeAll(group_adj_da, total_effective_groups, group_indegree, item_adj_in_group_da, n, item_indegree, items_in_group_list_da, sorted_items_in_group_da, group_deps_raw_data, &group_order_da, group_map, NULL, NULL);
        *returnSize = 0; return NULL;
    }
    for (int i = 0; i < total_effective_groups; i++) {
        initDynamicArray(&sorted_items_in_group_da[i], 4);
    }

    Queue* q_items = createQueue(n);
    if (!q_items) {
        freeAll(group_adj_da, total_effective_groups, group_indegree, item_adj_in_group_da, n, item_indegree, items_in_group_list_da, sorted_items_in_group_da, group_deps_raw_data, &group_order_da, group_map, NULL, NULL);
        *returnSize = 0; return NULL;
    }

    for (int g = 0; g < total_effective_groups; g++) {
        for (int i = 0; i < items_in_group_list_da[g].size; i++) {
            int item = items_in_group_list_da[g].data[i];
            if (item_indegree[item] == 0) {
                enqueue(q_items, item);
            }
        }

        int items_in_group_sorted_count = 0;
        while (!isEmpty(q_items)) {
            int u_item = dequeue(q_items);
            addDynamicArray(&sorted_items_in_group_da[g], u_item);
            items_in_group_sorted_count++;

            for (int i = 0; i < item_adj_in_group_da[u_item].size; i++) {
                int v_item = item_adj_in_group_da[u_item].data[i];
                item_indegree[v_item]--;
                if (item_indegree[v_item] == 0) {
                    enqueue(q_items, v_item);
                }
            }
        }

        if (items_in_group_sorted_count != items_in_group_list_da[g].size) {
            freeAll(group_adj_da, total_effective_groups, group_indegree, item_adj_in_group_da, n, item_indegree, items_in_group_list_da, sorted_items_in_group_da, group_deps_raw_data, &group_order_da, group_map, NULL, q_items);
            *returnSize = 0; return NULL;
        }
    }
    freeQueue(q_items);

    // 6. Combine results
    int* result = (int*)malloc(n * sizeof(int));
    if (!result) {
        freeAll(group_adj_da, total_effective_groups, group_indegree, item_adj_in_group_da, n, item_indegree, items_in_group_list_da, sorted_items_in_group_da, group_deps_raw_data, &group_order_da, group_map, NULL, NULL);
        *returnSize = 0; return NULL;
    }

    int result_idx = 0;
    for (int i = 0; i < group_order_da.size; i++) {
        int g = group_order_da.data[i];
        for (int j = 0; j < sorted_items_in_group_da[g].size; j++) {
            result[result_idx++] = sorted_items_in_group_da[g].data[j];
        }
    }
    *returnSize = n;

    // Free all dynamically allocated memory except the result array
    freeAll(group_adj_da, total_effective_groups, group_indegree, item_adj_in_group_da, n, item_indegree, items_in_group_list_da, sorted_items_in_group_da, group_deps_raw_data, &group_order_da, group_map, NULL, NULL);

    return result;
}