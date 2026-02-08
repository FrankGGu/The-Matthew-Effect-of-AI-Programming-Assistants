#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = NULL;
    q->size = 0;
    q->capacity = 0;
    return q;
}

void enqueue(Queue* q, int value) {
    if (q->size == q->capacity) {
        q->capacity = (q->capacity == 0) ? 1 : q->capacity * 2;
        q->data = (int*)realloc(q->data, q->capacity * sizeof(int));
    }
    q->data[q->size++] = value;
}

int dequeue(Queue* q) {
    int val = q->data[0];
    memmove(q->data, q->data + 1, (q->size - 1) * sizeof(int));
    q->size--;
    return val;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

typedef struct {
    int key;
    int value;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** table;
    int size;
} HashMap;

HashMap* createHashMap(int size) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    map->table = (HashNode**)calloc(size, sizeof(HashNode*));
    return map;
}

unsigned int hashFunction(int key, int size) {
    return (unsigned int)key % size;
}

void put(HashMap* map, int key, int value) {
    unsigned int index = hashFunction(key, map->size);
    HashNode* node = map->table[index];
    while (node != NULL) {
        if (node->key == key) {
            node->value = value;
            return;
        }
        node = node->next;
    }
    node = (HashNode*)malloc(sizeof(HashNode));
    node->key = key;
    node->value = value;
    node->next = map->table[index];
    map->table[index] = node;
}

int get(HashMap* map, int key) {
    unsigned int index = hashFunction(key, map->size);
    HashNode* node = map->table[index];
    while (node != NULL) {
        if (node->key == key) {
            return node->value;
        }
        node = node->next;
    }
    return -1;
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->size; i++) {
        HashNode* node = map->table[i];
        while (node != NULL) {
            HashNode* temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(map->table);
    free(map);
}

int numBusesToDestination(int** routes, int routesSize, int* routesColSize, int source, int target) {
    if (source == target) return 0;

    int i, j;
    int n = routesSize;
    int* visited = (int*)calloc(n, sizeof(int));
    Queue* queue = createQueue();
    HashMap* routeMap = createHashMap(1000);

    for (i = 0; i < n; i++) {
        for (j = 0; j < routesColSize[i]; j++) {
            int stop = routes[i][j];
            if (get(routeMap, stop) == -1) {
                put(routeMap, stop, i);
            } else {
                int prev = get(routeMap, stop);
                if (prev != i) {
                    enqueue(queue, i);
                    visited[i] = 1;
                }
            }
        }
    }

    int buses = 0;
    while (!isEmpty(queue)) {
        int size = queue->size;
        for (i = 0; i < size; i++) {
            int route = dequeue(queue);
            for (j = 0; j < routesColSize[route]; j++) {
                int stop = routes[route][j];
                if (stop == target) {
                    free(visited);
                    freeQueue(queue);
                    freeHashMap(routeMap);
                    return buses + 1;
                }
                int nextRoute = get(routeMap, stop);
                if (nextRoute != -1 && !visited[nextRoute]) {
                    visited[nextRoute] = 1;
                    enqueue(queue, nextRoute);
                }
            }
        }
        buses++;
    }

    free(visited);
    freeQueue(queue);
    freeHashMap(routeMap);
    return -1;
}