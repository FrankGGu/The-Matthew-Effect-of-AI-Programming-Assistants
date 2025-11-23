typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval* intervals;
    int size;
    int capacity;
} RangeModule;

RangeModule* rangeModuleCreate() {
    RangeModule* obj = (RangeModule*)malloc(sizeof(RangeModule));
    obj->size = 0;
    obj->capacity = 10;
    obj->intervals = (Interval*)malloc(obj->capacity * sizeof(Interval));
    return obj;
}

void rangeModuleAddRange(RangeModule* obj, int left, int right) {
    if (left >= right) return;
    while (obj->size > 0 && obj->intervals[obj->size - 1].end >= left) {
        left = fmin(left, obj->intervals[obj->size - 1].start);
        right = fmax(right, obj->intervals[obj->size - 1].end);
        obj->size--;
    }
    if (obj->size >= obj->capacity) {
        obj->capacity *= 2;
        obj->intervals = (Interval*)realloc(obj->intervals, obj->capacity * sizeof(Interval));
    }
    obj->intervals[obj->size++] = (Interval){left, right};
}

bool rangeModuleQuery(RangeModule* obj, int left, int right) {
    if (left >= right) return false;
    for (int i = 0; i < obj->size; i++) {
        if (obj->intervals[i].start <= left && obj->intervals[i].end >= right) {
            return true;
        }
    }
    return false;
}

void rangeModuleRemoveRange(RangeModule* obj, int left, int right) {
    if (left >= right) return;
    for (int i = 0; i < obj->size; i++) {
        if (obj->intervals[i].end <= left) continue;
        if (obj->intervals[i].start >= right) break;

        if (obj->intervals[i].start < left) {
            if (obj->intervals[i].end > right) {
                obj->intervals[obj->size++] = (Interval){right, obj->intervals[i].end};
            }
            obj->intervals[i].end = left;
        } else if (obj->intervals[i].start < right) {
            obj->intervals[i].start = right;
        } else {
            obj->size--;
            i--;
        }
    }
}

void rangeModuleFree(RangeModule* obj) {
    free(obj->intervals);
    free(obj);
}