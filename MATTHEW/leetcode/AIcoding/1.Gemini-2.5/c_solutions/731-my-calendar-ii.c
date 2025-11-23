#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memcpy if needed, but not in this solution

#define MAX_EVENTS 1000

#define MAX_OVERLAPS_TEMP (MAX_EVENTS + MAX_EVENTS)

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval events[MAX_EVENTS];
    int eventCount;
    Interval overlaps[MAX_EVENTS]; // Stores merged double-booked intervals
    int overlapCount;
} MyCalendarTwo;

static int compareIntervals(const void* a, const void* b) {
    return ((Interval*)a)->start - ((Interval*)b)->start;
}

MyCalendarTwo* myCalendarTwoCreate() {
    MyCalendarTwo* obj = (MyCalendarTwo*) malloc(sizeof(MyCalendarTwo));
    obj->eventCount = 0;
    obj->overlapCount = 0;
    return obj;
}

bool myCalendarTwoBook(MyCalendarTwo* obj, int start, int end) {
    // Step 1: Check for triple booking.
    // A triple booking occurs if the new event [start, end)
    // overlaps with any existing double-booked interval in obj->overlaps.
    for (int i = 0; i < obj->overlapCount; i++) {
        int overlapStart = obj->overlaps[i].start;
        int overlapEnd = obj->overlaps[i].end;

        // Check for overlap: max(start, overlapStart) < min(end, overlapEnd)
        if (start < overlapEnd && end > overlapStart) {
            return false; // Triple booking detected
        }
    }

    // Step 2: If no triple booking, calculate new double-booked intervals
    // and merge them with existing ones.
    Interval newOverlapCandidates[MAX_OVERLAPS_TEMP];
    int newOverlapCandidateCount = 0;

    // Add all existing merged overlaps to the temporary list of candidates.
    for (int i = 0; i < obj->overlapCount; i++) {
        newOverlapCandidates[newOverlapCandidateCount++] = obj->overlaps[i];
    }

    // Find new intersections between the current booking [start, end)
    // and all previously booked events in obj->events.
    for (int i = 0; i < obj->eventCount; i++) {
        int eventStart = obj->events[i].start;
        int eventEnd = obj->events[i].end;

        // Check if the new event [start, end) overlaps with an existing event [eventStart, eventEnd).
        if (start < eventEnd && end > eventStart) {
            // Calculate the intersection interval.
            int intersectionStart = (start > eventStart) ? start : eventStart;
            int intersectionEnd = (end < eventEnd) ? end : eventEnd;

            newOverlapCandidates[newOverlapCandidateCount].start = intersectionStart;
            newOverlapCandidates[newOverlapCandidateCount].end = intersectionEnd;
            newOverlapCandidateCount++;
        }
    }

    // Sort all candidate overlap intervals by their start times.
    qsort(newOverlapCandidates, newOverlapCandidateCount, sizeof(Interval), compareIntervals);

    // Merge the sorted candidate intervals to form the new set of merged overlaps.
    if (newOverlapCandidateCount > 0) {
        obj->overlaps[0] = newOverlapCandidates[0];
        obj->overlapCount = 1;

        for (int i = 1; i < newOverlapCandidateCount; i++) {
            // If the current candidate overlaps with the last merged interval, merge them.
            if (newOverlapCandidates[i].start < obj->overlaps[obj->overlapCount - 1].end) {
                obj->overlaps[obj->overlapCount - 1].end = 
                    (newOverlapCandidates[i].end > obj->overlaps[obj->overlapCount - 1].end) ? 
                    newOverlapCandidates[i].end : obj->overlaps[obj->overlapCount - 1].end;
            } else {
                // Otherwise, add it as a new distinct merged interval.
                obj->overlaps[obj->overlapCount++] = newOverlapCandidates[i];
            }
        }
    } else {
        obj->overlapCount = 0; // No overlaps exist after this booking.
    }

    // Step 3: Add the new event to the list of successfully booked events.
    obj->events[obj->eventCount].start = start;
    obj->events[obj->eventCount].end = end;
    obj->eventCount++;

    return true;
}

void myCalendarTwoFree(MyCalendarTwo* obj) {
    free(obj);
}