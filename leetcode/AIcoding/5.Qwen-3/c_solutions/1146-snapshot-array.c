#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int* snapshots;
    int size;
    int snap_id;
} SnapshotArray;

SnapshotArray* snapshotArrayCreate(int length) {
    SnapshotArray* obj = (SnapshotArray*)malloc(sizeof(SnapshotArray));
    obj->data = (int*)calloc(length, sizeof(int));
    obj->snapshots = (int*)calloc(length, sizeof(int));
    obj->size = length;
    obj->snap_id = 0;
    return obj;
}

void snapshotArraySet(SnapshotArray* obj, int index, int val) {
    obj->data[index] = val;
    obj->snapshots[index] = obj->snap_id;
}

int snapshotArraySnap(SnapshotArray* obj) {
    return obj->snap_id++;
}

int snapshotArrayGet(SnapshotArray* obj, int index, int snap_id) {
    if (obj->snapshots[index] == snap_id) {
        return obj->data[index];
    }
    return 0;
}

void snapshotArrayFree(SnapshotArray* obj) {
    free(obj->data);
    free(obj->snapshots);
    free(obj);
}