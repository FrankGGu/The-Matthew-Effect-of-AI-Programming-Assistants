#include <stdlib.h> // For malloc, free, qsort

typedef struct {
    int time;
    int delta; // +1 for a start event, -1 for an end event
} EventPoint;

int compareEventPoints(const void *a, const void *b) {
    EventPoint *epa = (EventPoint *)a;
    EventPoint *epb = (EventPoint *)b;

    if (epa->time != epb->time) {
        return epa->time - epb->time;
    }
    // If times are equal, process end events (-1) before start events (+1)
    return epa->delta - epb->delta;
}

typedef struct {
    // Max 1000 calls to book, each adds 2 points (start and end)
    // So, a fixed-size array of 2000 EventPoints is sufficient.
    EventPoint eventPoints[2000];
    int eventCount; // Current number of EventPoints stored in the array
} MyCalendarThree;

MyCalendarThree* myCalendarThreeCreate() {
    MyCalendarThree* obj = (MyCalendarThree*) malloc(sizeof(MyCalendarThree));
    if (obj == NULL) {
        // Handle allocation failure if necessary, though LeetCode usually assumes success.
        return NULL;
    }
    obj->eventCount = 0;
    return obj;
}

int myCalendarThreeBook(MyCalendarThree* obj, int start, int end) {
    // Add the start point of the new event
    obj->eventPoints[obj->eventCount].time = start;
    obj->eventPoints[obj->eventCount].delta = 1;
    obj->eventCount++;

    // Add the end point of the new event
    // Note: The problem defines intervals as [start, end), so the event ends at 'end'.
    // We mark 'end' as a point where an event finishes, hence delta -1.
    obj->eventPoints[obj->eventCount].time = end;
    obj->eventPoints[obj->eventCount].delta = -1;
    obj->eventCount++;

    // Sort all accumulated event points to perform a sweep-line algorithm.
    // This sorting step dominates the time complexity for each book call.
    qsort(obj->eventPoints, obj->eventCount, sizeof(EventPoint), compareEventPoints);

    int currentOverlap = 0; // Tracks the number of active events at the current time
    int maxOverlap = 0;     // Stores the maximum overlap found so far

    // Iterate through the sorted event points
    for (int i = 0; i < obj->eventCount; i++) {
        currentOverlap += obj->eventPoints[i].delta; // Update current overlap based on event type
        if (currentOverlap > maxOverlap) {
            maxOverlap = currentOverlap; // Update maxOverlap if a new peak is found
        }
    }

    return maxOverlap;
}

void myCalendarThreeFree(MyCalendarThree* obj) {
    free(obj);
}