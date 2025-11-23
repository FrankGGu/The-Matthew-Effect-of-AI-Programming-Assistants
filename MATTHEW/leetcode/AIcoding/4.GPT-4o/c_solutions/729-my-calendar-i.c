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
    MyCalendar* calendar = (MyCalendar*)malloc(sizeof(MyCalendar));
    calendar->events = (Event*)malloc(sizeof(Event) * 1000);
    calendar->size = 0;
    calendar->capacity = 1000;
    return calendar;
}

int myCalendarBook(MyCalendar* obj, int start, int end) {
    for (int i = 0; i < obj->size; i++) {
        if (start < obj->events[i].end && end > obj->events[i].start) {
            return 0;
        }
    }
    obj->events[obj->size++] = (Event){start, end};
    return 1;
}

void myCalendarFree(MyCalendar* obj) {
    free(obj->events);
    free(obj);
}