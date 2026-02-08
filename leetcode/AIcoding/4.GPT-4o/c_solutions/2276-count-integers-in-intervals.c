typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    int* counts;
    int size;
} CountIntervals;

CountIntervals* countIntervalsCreate() {
    CountIntervals* obj = (CountIntervals*)malloc(sizeof(CountIntervals));
    obj->counts = (int*)calloc(10001, sizeof(int));
    obj->size = 0;
    return obj;
}

void countIntervalsAdd(CountIntervals* obj, int left, int right) {
    for (int i = left; i <= right; i++) {
        if (obj->counts[i] == 0) {
            obj->size++;
        }
        obj->counts[i]++;
    }
}

int countIntervalsCount(CountIntervals* obj) {
    return obj->size;
}

void countIntervalsFree(CountIntervals* obj) {
    free(obj->counts);
    free(obj);
}