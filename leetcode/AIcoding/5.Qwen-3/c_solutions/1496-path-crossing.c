#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point* points;
    int size;
    int capacity;
} HashSet;

HashSet* createHashSet() {
    HashSet* set = (HashSet*)malloc(sizeof(HashSet));
    set->size = 0;
    set->capacity = 16;
    set->points = (Point*)malloc(set->capacity * sizeof(Point));
    return set;
}

void addPoint(HashSet* set, int x, int y) {
    for (int i = 0; i < set->size; i++) {
        if (set->points[i].x == x && set->points[i].y == y) {
            return;
        }
    }
    if (set->size >= set->capacity) {
        set->capacity *= 2;
        set->points = (Point*)realloc(set->points, set->capacity * sizeof(Point));
    }
    set->points[set->size].x = x;
    set->points[set->size].y = y;
    set->size++;
}

int isCrossing(HashSet* set, int x, int y) {
    for (int i = 0; i < set->size; i++) {
        if (set->points[i].x == x && set->points[i].y == y) {
            return 1;
        }
    }
    return 0;
}

void freeHashSet(HashSet* set) {
    free(set->points);
    free(set);
}

bool isPathCrossing(char* path) {
    HashSet* set = createHashSet();
    int x = 0, y = 0;
    addPoint(set, x, y);
    for (int i = 0; i < strlen(path); i++) {
        switch (path[i]) {
            case 'U':
                y += 1;
                break;
            case 'D':
                y -= 1;
                break;
            case 'L':
                x -= 1;
                break;
            case 'R':
                x += 1;
                break;
        }
        if (isCrossing(set, x, y)) {
            freeHashSet(set);
            return true;
        }
        addPoint(set, x, y);
    }
    freeHashSet(set);
    return false;
}