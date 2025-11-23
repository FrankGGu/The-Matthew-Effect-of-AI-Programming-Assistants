typedef struct {
    int start;
    int end;
} MyCalendar;

MyCalendar* myCalendarCreate() {
    MyCalendar *obj = (MyCalendar*)malloc(1000 * sizeof(MyCalendar));
    return obj;
}

bool myCalendarBook(MyCalendar* obj, int start, int end, int* size) {
    for (int i = 0; i < *size; i++) {
        if (start < obj[i].end && end > obj[i].start) {
            return false;
        }
    }
    obj[*size].start = start;
    obj[*size].end = end;
    (*size)++;
    return true;
}

void myCalendarFree(MyCalendar* obj) {
    free(obj);
}