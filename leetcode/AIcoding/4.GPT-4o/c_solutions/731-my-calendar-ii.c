typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval *intervals;
    int size;
} MyCalendarTwo;

MyCalendarTwo* myCalendarTwoCreate() {
    MyCalendarTwo *obj = (MyCalendarTwo *)malloc(sizeof(MyCalendarTwo));
    obj->intervals = (Interval *)malloc(sizeof(Interval) * 10000);
    obj->size = 0;
    return obj;
}

bool myCalendarTwoBook(MyCalendarTwo* obj, int start, int end) {
    Interval newInterval = {start, end};
    int overlap = 0;

    for (int i = 0; i < obj->size; i++) {
        Interval current = obj->intervals[i];
        if (!(newInterval.end <= current.start || newInterval.start >= current.end)) {
            overlap++;
            if (overlap > 1) {
                return false;
            }
        }
    }

    obj->intervals[obj->size++] = newInterval;
    return true;
}

void myCalendarTwoFree(MyCalendarTwo* obj) {
    free(obj->intervals);
    free(obj);
}