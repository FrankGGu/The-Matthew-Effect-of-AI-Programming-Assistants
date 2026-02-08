#include <stdlib.h>

struct Event {
    int time;
    int count;
    struct Event* next;
};

struct MyCalendarThree {
    struct Event* head;
};

struct MyCalendarThree* myCalendarThreeCreate() {
    struct MyCalendarThree* obj = (struct MyCalendarThree*)malloc(sizeof(struct MyCalendarThree));
    obj->head = NULL;
    return obj;
}

void insertEvent(struct MyCalendarThree* obj, int time) {
    struct Event* newEvent = (struct Event*)malloc(sizeof(struct Event));
    newEvent->time = time;
    newEvent->count = 1;
    newEvent->next = NULL;

    if (!obj->head || obj->head->time > time) {
        newEvent->next = obj->head;
        obj->head = newEvent;
    } else {
        struct Event* curr = obj->head;
        while (curr->next && curr->next->time <= time) {
            curr = curr->next;
        }
        if (curr->time == time) {
            curr->count++;
        } else {
            newEvent->next = curr->next;
            curr->next = newEvent;
        }
    }
}

int myCalendarThreeBook(struct MyCalendarThree* obj, int start, int end) {
    insertEvent(obj, start);
    insertEvent(obj, end);

    int maxCount = 0;
    int currentCount = 0;
    struct Event* curr = obj->head;

    while (curr) {
        currentCount += curr->count;
        if (currentCount > maxCount) {
            maxCount = currentCount;
        }
        curr = curr->next;
    }
    return maxCount;
}

void myCalendarThreeFree(struct MyCalendarThree* obj) {
    struct Event* curr = obj->head;
    while (curr) {
        struct Event* temp = curr;
        curr = curr->next;
        free(temp);
    }
    free(obj);
}