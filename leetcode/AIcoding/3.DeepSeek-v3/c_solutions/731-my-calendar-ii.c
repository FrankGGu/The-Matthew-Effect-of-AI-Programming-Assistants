typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval* single_bookings;
    Interval* double_bookings;
    int single_size;
    int double_size;
    int single_capacity;
    int double_capacity;
} MyCalendarTwo;

MyCalendarTwo* myCalendarTwoCreate() {
    MyCalendarTwo* obj = (MyCalendarTwo*)malloc(sizeof(MyCalendarTwo));
    obj->single_capacity = 16;
    obj->double_capacity = 16;
    obj->single_size = 0;
    obj->double_size = 0;
    obj->single_bookings = (Interval*)malloc(obj->single_capacity * sizeof(Interval));
    obj->double_bookings = (Interval*)malloc(obj->double_capacity * sizeof(Interval));
    return obj;
}

bool myCalendarTwoBook(MyCalendarTwo* obj, int start, int end) {
    for (int i = 0; i < obj->double_size; i++) {
        if (start < obj->double_bookings[i].end && end > obj->double_bookings[i].start) {
            return false;
        }
    }

    for (int i = 0; i < obj->single_size; i++) {
        if (start < obj->single_bookings[i].end && end > obj->single_bookings[i].start) {
            int overlap_start = (start > obj->single_bookings[i].start) ? start : obj->single_bookings[i].start;
            int overlap_end = (end < obj->single_bookings[i].end) ? end : obj->single_bookings[i].end;

            if (obj->double_size >= obj->double_capacity) {
                obj->double_capacity *= 2;
                obj->double_bookings = (Interval*)realloc(obj->double_bookings, obj->double_capacity * sizeof(Interval));
            }
            obj->double_bookings[obj->double_size].start = overlap_start;
            obj->double_bookings[obj->double_size].end = overlap_end;
            obj->double_size++;
        }
    }

    if (obj->single_size >= obj->single_capacity) {
        obj->single_capacity *= 2;
        obj->single_bookings = (Interval*)realloc(obj->single_bookings, obj->single_capacity * sizeof(Interval));
    }
    obj->single_bookings[obj->single_size].start = start;
    obj->single_bookings[obj->single_size].end = end;
    obj->single_size++;

    return true;
}

void myCalendarTwoFree(MyCalendarTwo* obj) {
    free(obj->single_bookings);
    free(obj->double_bookings);
    free(obj);
}