#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int snap_id;
    int val;
} Snapshot;

typedef struct {
    Snapshot *snapshots;
    int size;
    int capacity;
} History;

typedef struct {
    History *array;
    int length;
    int snap_count;
} SnapshotArray;

History* historyCreate(int capacity) {
    History* h = (History*)malloc(sizeof(History));
    h->snapshots = (Snapshot*)malloc(capacity * sizeof(Snapshot));
    h->size = 0;
    h->capacity = capacity;
    return h;
}

void historyAppend(History* h, int snap_id, int val) {
    if (h->size == h->capacity) {
        h->capacity *= 2;
        h->snapshots = (Snapshot*)realloc(h->snapshots, h->capacity * sizeof(Snapshot));
    }
    h->snapshots[h->size].snap_id = snap_id;
    h->snapshots[h->size].val = val;
    h->size++;
}

int historyGet(History* h, int snap_id) {
    int left = 0;
    int right = h->size - 1;
    int result = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (h->snapshots[mid].snap_id <= snap_id) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    if (result == -1) {
        return 0;
    } else {
        return h->snapshots[result].val;
    }
}

void historyFree(History* h) {
    free(h->snapshots);
    free(h);
}

SnapshotArray* snapshotArrayCreate(int length) {
    SnapshotArray* obj = (SnapshotArray*)malloc(sizeof(SnapshotArray));
    obj->array = (History*)malloc(length * sizeof(History));
    obj->length = length;
    obj->snap_count = 0;

    for (int i = 0; i < length; i++) {
        obj->array[i] = *historyCreate(1);
    }

    return obj;
}

void snapshotArraySet(SnapshotArray* obj, int index, int val) {
    historyAppend(&obj->array[index], obj->snap_count, val);
}

int snapshotArraySnap(SnapshotArray* obj) {
    return obj->snap_count++;
}

int snapshotArrayGet(SnapshotArray* obj, int index, int snap_id) {
    return historyGet(&obj->array[index], snap_id);
}

void snapshotArrayFree(SnapshotArray* obj) {
    for (int i = 0; i < obj->length; i++) {
        historyFree(&obj->array[i]);
    }
    free(obj->array);
    free(obj);
}