typedef struct {
    int snap_id;
    int val;
} SnapshotEntry;

typedef struct {
    SnapshotEntry* entries;
    int size;
    int capacity;
} History;

typedef struct {
    History* array;
    int length;
    int snap_id;
} SnapshotArray;

SnapshotArray* snapshotArrayCreate(int length) {
    SnapshotArray* obj = (SnapshotArray*)malloc(sizeof(SnapshotArray));
    obj->length = length;
    obj->snap_id = 0;
    obj->array = (History*)malloc(length * sizeof(History));

    for (int i = 0; i < length; i++) {
        obj->array[i].size = 0;
        obj->array[i].capacity = 1;
        obj->array[i].entries = (SnapshotEntry*)malloc(sizeof(SnapshotEntry));
        obj->array[i].entries[0].snap_id = 0;
        obj->array[i].entries[0].val = 0;
        obj->array[i].size = 1;
    }

    return obj;
}

void snapshotArraySet(SnapshotArray* obj, int index, int val) {
    History* hist = &obj->array[index];

    if (hist->entries[hist->size - 1].snap_id == obj->snap_id) {
        hist->entries[hist->size - 1].val = val;
    } else {
        if (hist->size >= hist->capacity) {
            hist->capacity *= 2;
            hist->entries = (SnapshotEntry*)realloc(hist->entries, hist->capacity * sizeof(SnapshotEntry));
        }
        hist->entries[hist->size].snap_id = obj->snap_id;
        hist->entries[hist->size].val = val;
        hist->size++;
    }
}

int snapshotArraySnap(SnapshotArray* obj) {
    return obj->snap_id++;
}

int snapshotArrayGet(SnapshotArray* obj, int index, int snap_id) {
    History* hist = &obj->array[index];

    int left = 0, right = hist->size - 1;
    int result = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (hist->entries[mid].snap_id <= snap_id) {
            result = hist->entries[mid].val;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}

void snapshotArrayFree(SnapshotArray* obj) {
    for (int i = 0; i < obj->length; i++) {
        free(obj->array[i].entries);
    }
    free(obj->array);
    free(obj);
}