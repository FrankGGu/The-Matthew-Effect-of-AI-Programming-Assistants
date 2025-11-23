#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point key;
    int count;
    struct Node* next;
} Node;

typedef struct {
    Node** buckets;
    int size;
    int capacity;
} HashMap;

HashMap* createHashMap(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->size = 0;
    map->buckets = (Node**)calloc(capacity, sizeof(Node*));
    return map;
}

unsigned int hash(Point p, int capacity) {
    unsigned int h = (unsigned int)(p.x * 31 + p.y * 37);
    return h % capacity;
}

Node* findNode(HashMap* map, Point p) {
    unsigned int index = hash(p, map->capacity);
    Node* current = map->buckets[index];
    while (current != NULL) {
        if (current->key.x == p.x && current->key.y == p.y) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

void put(HashMap* map, Point p) {
    Node* node = findNode(map, p);
    if (node != NULL) {
        node->count++;
    } else {
        unsigned int index = hash(p, map->capacity);
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->key = p;
        newNode->count = 1;
        newNode->next = map->buckets[index];
        map->buckets[index] = newNode;
        map->size++;
    }
}

int get(HashMap* map, Point p) {
    Node* node = findNode(map, p);
    return node != NULL ? node->count : 0;
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->capacity; i++) {
        Node* current = map->buckets[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

int countPairs(int** points, int pointsSize, int* pointsColSize, int k) {
    HashMap* map = createHashMap(pointsSize * 2); // Heuristic capacity
    long long pairCount = 0;

    for (int i = 0; i < pointsSize; i++) {
        Point p = {points[i][0], points[i][1]};
        put(map, p);
    }

    for (int i = 0; i < map->capacity; i++) {
        Node* current = map->buckets[i];
        while (current != NULL) {
            Point p1 = current->key;
            int count1 = current->count;

            for (int dx = 0; dx <= k; dx++) {
                int dy = k - dx;

                Point p2_candidate1 = {p1.x + dx, p1.y + dy};
                int count2_1 = get(map, p2_candidate1);
                if (count2_1 > 0) {
                    if (p1.x == p2_candidate1.x && p1.y == p2_candidate1.y) {
                        pairCount += (long long)count1 * (count1 - 1);
                    } else {
                        pairCount += (long long)count1 * count2_1;
                    }
                }

                if (dy != 0) { // Avoid double counting for dy=0 (already covered by p2_candidate1)
                    Point p2_candidate2 = {p1.x + dx, p1.y - dy};
                    int count2_2 = get(map, p2_candidate2);
                    if (count2_2 > 0) {
                        pairCount += (long long)count1 * count2_2;
                    }
                }

                if (dx != 0) { // Avoid double counting for dx=0 (already covered by p2_candidate1)
                    Point p2_candidate3 = {p1.x - dx, p1.y + dy};
                    int count2_3 = get(map, p2_candidate3);
                    if (count2_3 > 0) {
                        pairCount += (long long)count1 * count2_3;
                    }
                }

                if (dx != 0 && dy != 0) { // Avoid double counting for dx=0 or dy=0
                    Point p2_candidate4 = {p1.x - dx, p1.y - dy};
                    int count2_4 = get(map, p2_candidate4);
                    if (count2_4 > 0) {
                        pairCount += (long long)count1 * count2_4;
                    }
                }
            }
            current = current->next;
        }
    }

    freeHashMap(map);

    return (int)(pairCount / 2);
}