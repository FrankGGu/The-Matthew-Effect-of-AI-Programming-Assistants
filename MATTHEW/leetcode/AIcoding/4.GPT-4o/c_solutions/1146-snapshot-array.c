#include <stdlib.h>

typedef struct {
    int **snapshots;
    int snap_id;
    int length;
} SnapshotArray;

SnapshotArray* snapshotArrayCreate(int length) {
    SnapshotArray *snapArray = (SnapshotArray *)malloc(sizeof(SnapshotArray));
    snapArray->length = length;
    snapArray->snap_id = 0;
    snapArray->snapshots = (int **)malloc(length * sizeof(int *));
    for (int i = 0; i < length; i++) {
        snapArray->snapshots[i] = (int *)malloc(2 * sizeof(int));
        snapArray->snapshots[i][0] = -1;
        snapArray->snapshots[i][1] = 0;
    }
    return snapArray;
}

void snapshotArraySet(SnapshotArray* obj, int index, int val) {
    if (obj->snapshots[index][0] == obj->snap_id) {
        obj->snapshots[index][1] = val;
    } else {
        obj->snapshots[index][0] = obj->snap_id;
        obj->snapshots[index][1] = val;
    }
}

int snapshotArraySnap(SnapshotArray* obj) {
    return obj->snap_id++;
}

int snapshotArrayGet(SnapshotArray* obj, int index, int snap_id) {
    for (int i = snap_id; i >= 0; i--) {
        if (obj->snapshots[index][0] == i) {
            return obj->snapshots[index][1];
        }
    }
    return 0;
}

void snapshotArrayFree(SnapshotArray* obj) {
    for (int i = 0; i < obj->length; i++) {
        free(obj->snapshots[i]);
    }
    free(obj->snapshots);
    free(obj);
}