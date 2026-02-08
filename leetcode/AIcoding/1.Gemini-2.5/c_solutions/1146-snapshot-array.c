#include <stdlib.h>

typedef struct {
    int snapId;
    int val;
} SnapValue;

typedef struct {
    SnapValue* arr;
    int capacity;
    int size;
} Vector;

Vector* vector_create() {
    Vector* vec = (Vector*)malloc(sizeof(Vector));
    vec->arr = NULL;
    vec->capacity = 0;
    vec->size = 0;
    return vec;
}

void vector_push_back(Vector* vec, int snapId, int val) {
    if (vec->size == vec->capacity) {
        int new_capacity = (vec->capacity == 0) ? 4 : vec->capacity * 2;
        vec->arr = (SnapValue*)realloc(vec->arr, new_capacity * sizeof(SnapValue));
        vec->capacity = new_capacity;
    }
    vec->arr[vec->size].snapId = snapId;
    vec->arr[vec->size].val = val;
    vec->size++;
}

int vector_get_val_at_snap(Vector* vec, int snap_id) {
    int low = 0;
    int high = vec->size - 1;
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (vec->arr[mid].snapId <= snap_id) {
            ans = vec->arr[mid].val;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans;
}

void vector_free(Vector* vec) {
    free(vec->arr);
    free(vec);
}

typedef struct {
    int current_snap_id;
    Vector** data;
    int length;
} SnapshotArray;

SnapshotArray* snapshotArrayCreate(int length) {
    SnapshotArray* obj = (SnapshotArray*)malloc(sizeof(SnapshotArray));
    obj->current_snap_id = 0;
    obj->length = length;
    obj->data = (Vector**)malloc(sizeof(Vector*) * length);
    for (int i = 0; i < length; ++i) {
        obj->data[i] = vector_create();
    }
    return obj;
}

void snapshotArraySet(SnapshotArray* obj, int index, int val) {
    vector_push_back(obj->data[index], obj->current_snap_id, val);
}

int snapshotArrayGet(SnapshotArray* obj, int index, int snap_id) {
    return vector_get_val_at_snap(obj->data[index], snap_id);
}

int snapshotArraySnapshot(SnapshotArray* obj) {
    return obj->current_snap_id++;
}

void snapshotArrayFree(SnapshotArray* obj) {
    for (int i = 0; i < obj->length; ++i) {
        vector_free(obj->data[i]);
    }
    free(obj->data);
    free(obj);
}