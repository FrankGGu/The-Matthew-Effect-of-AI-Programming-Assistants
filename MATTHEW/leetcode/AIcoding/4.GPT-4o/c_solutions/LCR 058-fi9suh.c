#include <stdbool.h>

typedef struct {
    int start;
    int end;
} MyCalendar;

MyCalendar* myCalendarCreate() {
    MyCalendar* obj = (MyCalendar*)malloc(sizeof(MyCalendar) * 1000);
    obj->start = -1;
    obj->end = -1;
    return obj;
}

bool myCalendarBook(MyCalendar* obj, int start, int end) {
    if (obj->end <= start) {
        obj->start = start;
        obj->end = end;
        return true;
    }
    return false;
}

void myCalendarFree(MyCalendar* obj) {
    free(obj);
}