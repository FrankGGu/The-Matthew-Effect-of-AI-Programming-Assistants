typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashItem;

typedef struct {
    int *arr;
    int front;
    int rear;
    int size;
} Queue;

Queue* createQueue(int size) {
    Queue* obj = (Queue*)malloc(sizeof(Queue));
    obj->arr = (int*)malloc(sizeof(int) * size);
    obj->front = 0;
    obj->rear = 0;
    obj->size = size;
    return obj;
}

bool isEmpty(Queue* obj) {
    return obj->front == obj->rear;
}

void push(Queue* obj, int x) {
    obj->arr[obj->rear++] = x;
}

int pop(Queue* obj) {
    return obj->arr[obj->front++];
}

void freeQueue(Queue* obj) {
    free(obj->arr);
    free(obj);
}

int minJumps(int* arr, int arrSize) {
    if (arrSize == 1) return 0;

    HashItem *graph = NULL;
    for (int i = 0; i < arrSize; i++) {
        HashItem *pEntry = NULL;
        HASH_FIND_INT(graph, &arr[i], pEntry);
        if (pEntry == NULL) {
            pEntry = (HashItem*)malloc(sizeof(HashItem));
            pEntry->key = arr[i];
            pEntry->val = i;
            HASH_ADD_INT(graph, key, pEntry);
        }
    }

    bool *visited = (bool*)malloc(sizeof(bool) * arrSize);
    memset(visited, 0, sizeof(bool) * arrSize);
    visited[0] = true;

    Queue *q = createQueue(arrSize * 2);
    push(q, 0);

    int steps = 0;
    while (!isEmpty(q)) {
        int size = q->rear - q->front;
        for (int i = 0; i < size; i++) {
            int curr = pop(q);

            if (curr == arrSize - 1) {
                HashItem *cur, *tmp;
                HASH_ITER(hh, graph, cur, tmp) {
                    HASH_DEL(graph, cur);
                    free(cur);
                }
                free(visited);
                freeQueue(q);
                return steps;
            }

            HashItem *pEntry = NULL;
            HASH_FIND_INT(graph, &arr[curr], pEntry);
            if (pEntry != NULL) {
                int value = arr[curr];
                HashItem *tmpEntry;
                HASH_FIND_INT(graph, &value, tmpEntry);
                if (tmpEntry != NULL) {
                    HASH_DEL(graph, tmpEntry);
                    free(tmpEntry);
                }

                for (int j = 0; j < arrSize; j++) {
                    if (arr[j] == value && j != curr && !visited[j]) {
                        visited[j] = true;
                        push(q, j);
                    }
                }
            }

            if (curr + 1 < arrSize && !visited[curr + 1]) {
                visited[curr + 1] = true;
                push(q, curr + 1);
            }

            if (curr - 1 >= 0 && !visited[curr - 1]) {
                visited[curr - 1] = true;
                push(q, curr - 1);
            }
        }
        steps++;
    }

    HashItem *cur, *tmp;
    HASH_ITER(hh, graph, cur, tmp) {
        HASH_DEL(graph, cur);
        free(cur);
    }
    free(visited);
    freeQueue(q);
    return -1;
}