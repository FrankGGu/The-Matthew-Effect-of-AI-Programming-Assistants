typedef struct {
    int start;
    int end;
} Event;

typedef struct {
    Event* events;
    int size;
    int capacity;
} MyCalendar;

MyCalendar* myCalendarCreate() {
    MyCalendar* obj = (MyCalendar*)malloc(sizeof(MyCalendar));
    obj->size = 0;
    obj->capacity = 10;
    obj->events = (Event*)malloc(obj->capacity * sizeof(Event));
    return obj;
}

bool myCalendarBook(MyCalendar* obj, int start, int end) {
    for (int i = 0; i < obj->size; i++) {
        Event e = obj->events[i];
        if (start < e.end && end > e.start) {
            return false;
        }
    }

    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->events = (Event*)realloc(obj->events, obj->capacity * sizeof(Event));
    }

    obj->events[obj->size].start = start;
    obj->events[obj->size].end = end;
    obj->size++;
    return true;
}

void myCalendarFree(MyCalendar* obj) {
    free(obj->events);
    free(obj);
}

/**
 * Your MyCalendar struct will be instantiated and called as such:
 * MyCalendar* obj = myCalendarCreate();
 * bool param_1 = myCalendarBook(obj, start, end);

 * myCalendarFree(obj);
*/