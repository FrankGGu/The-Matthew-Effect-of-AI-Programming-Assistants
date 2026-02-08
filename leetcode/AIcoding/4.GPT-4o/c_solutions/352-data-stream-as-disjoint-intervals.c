#define MAX_SIZE 10000

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval intervals[MAX_SIZE];
    int size;
} SummaryRanges;

SummaryRanges* summaryRangesCreate() {
    SummaryRanges* obj = (SummaryRanges*)malloc(sizeof(SummaryRanges));
    obj->size = 0;
    return obj;
}

void summaryRangesAddNum(SummaryRanges* obj, int val) {
    int i = 0;
    while (i < obj->size && obj->intervals[i].end < val) {
        i++;
    }
    if (i > 0 && obj->intervals[i - 1].end + 1 >= val) {
        if (obj->intervals[i - 1].end < val) {
            obj->intervals[i - 1].end = val;
        }
    } else if (i < obj->size && obj->intervals[i].start - 1 <= val) {
        if (obj->intervals[i].start > val) {
            Interval newInterval = {val, val};
            memmove(&obj->intervals[i + 1], &obj->intervals[i], (obj->size - i) * sizeof(Interval));
            obj->intervals[i] = newInterval;
            obj->size++;
        }
        obj->intervals[i].start = fmin(obj->intervals[i].start, val);
    } else {
        Interval newInterval = {val, val};
        memmove(&obj->intervals[i + 1], &obj->intervals[i], (obj->size - i) * sizeof(Interval));
        obj->intervals[i] = newInterval;
        obj->size++;
    }
}

int** summaryRangesGetIntervals(SummaryRanges* obj, int* returnSize) {
    *returnSize = obj->size;
    int** result = (int**)malloc(obj->size * sizeof(int*));
    for (int i = 0; i < obj->size; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        result[i][0] = obj->intervals[i].start;
        result[i][1] = obj->intervals[i].end;
    }
    return result;
}

void summaryRangesFree(SummaryRanges* obj) {
    free(obj);
}