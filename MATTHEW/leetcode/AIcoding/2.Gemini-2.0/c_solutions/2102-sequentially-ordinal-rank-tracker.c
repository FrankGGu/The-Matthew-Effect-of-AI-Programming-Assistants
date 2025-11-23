#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    double score;
    int index;
} Node;

int compare(const void *a, const void *b) {
    Node *nodeA = (Node *)a;
    Node *nodeB = (Node *)b;
    if (nodeA->score != nodeB->score) {
        if (nodeA->score > nodeB->score) {
            return -1;
        } else {
            return 1;
        }
    } else {
        return nodeA->index - nodeB->index;
    }
}

typedef struct {
    Node *arr;
    int size;
    int capacity;
    int current_index;
} SORTracker;

SORTracker *sorTrackerCreate() {
    SORTracker *tracker = (SORTracker *)malloc(sizeof(SORTracker));
    tracker->capacity = 100001;
    tracker->size = 0;
    tracker->arr = (Node *)malloc(tracker->capacity * sizeof(Node));
    tracker->current_index = 0;
    return tracker;
}

void sorTrackerAdd(SORTracker *obj, int score) {
    obj->arr[obj->size].score = (double)score;
    obj->arr[obj->size].index = obj->current_index;
    obj->size++;
    obj->current_index++;
    qsort(obj->arr, obj->size, sizeof(Node), compare);
}

int sorTrackerGet(SORTracker *obj, int k) {
    return (int)obj->arr[k - 1].score;
}

void sorTrackerFree(SORTracker *obj) {
    free(obj->arr);
    free(obj);
}