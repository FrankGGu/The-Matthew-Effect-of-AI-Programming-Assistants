#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Interval {
    int start;
    int end;
    struct Interval* next;
} Interval;

typedef struct {
    Interval* head;
} RangeModule;

RangeModule* rangeModuleCreate() {
    RangeModule* obj = (RangeModule*)malloc(sizeof(RangeModule));
    obj->head = NULL;
    return obj;
}

void rangeModuleAddRange(RangeModule* obj, int left, int right) {
    Interval* curr = obj->head;
    Interval* prev = NULL;
    Interval* newInterval = (Interval*)malloc(sizeof(Interval));
    newInterval->start = left;
    newInterval->end = right;
    newInterval->next = NULL;

    while (curr != NULL) {
        if (newInterval->end < curr->start) {
            newInterval->next = curr;
            if (prev == NULL) {
                obj->head = newInterval;
            } else {
                prev->next = newInterval;
            }
            return;
        } else if (newInterval->start > curr->end) {
            prev = curr;
            curr = curr->next;
        } else {
            newInterval->start = (newInterval->start < curr->start) ? newInterval->start : curr->start;
            newInterval->end = (newInterval->end > curr->end) ? newInterval->end : curr->end;
            Interval* temp = curr;
            if (prev == NULL) {
                obj->head = curr->next;
            } else {
                prev->next = curr->next;
            }
            curr = curr->next;
            free(temp);

            while (curr != NULL && newInterval->end >= curr->start) {
                newInterval->end = (newInterval->end > curr->end) ? newInterval->end : curr->end;
                temp = curr;
                if (prev == NULL) {
                    obj->head = curr->next;
                } else {
                    prev->next = curr->next;
                }
                curr = curr->next;
                free(temp);
            }

            newInterval->next = curr;
            if (prev == NULL) {
                obj->head = newInterval;
            } else {
                prev->next = newInterval;
            }
            return;
        }
    }

    if (prev == NULL) {
        obj->head = newInterval;
    } else {
        prev->next = newInterval;
    }
}

bool rangeModuleQueryRange(RangeModule* obj, int left, int right) {
    Interval* curr = obj->head;
    while (curr != NULL) {
        if (curr->start <= left && curr->end >= right) {
            return true;
        } else if (curr->start > right) {
            return false;
        }
        curr = curr->next;
    }
    return false;
}

void rangeModuleRemoveRange(RangeModule* obj, int left, int right) {
    Interval* curr = obj->head;
    Interval* prev = NULL;

    while (curr != NULL) {
        if (right < curr->start) {
            return;
        } else if (left > curr->end) {
            prev = curr;
            curr = curr->next;
        } else {
            if (left <= curr->start && right >= curr->end) {
                Interval* temp = curr;
                if (prev == NULL) {
                    obj->head = curr->next;
                } else {
                    prev->next = curr->next;
                }
                curr = curr->next;
                free(temp);
            } else if (left > curr->start && right < curr->end) {
                Interval* newInterval = (Interval*)malloc(sizeof(Interval));
                newInterval->start = right;
                newInterval->end = curr->end;
                newInterval->next = curr->next;
                curr->end = left;
                curr->next = newInterval;
                return;
            } else if (left <= curr->start && right < curr->end) {
                curr->start = right;
                return;
            } else if (left > curr->start && right >= curr->end) {
                curr->end = left;
                prev = curr;
                curr = curr->next;
            }
        }
    }
}

void rangeModuleFree(RangeModule* obj) {
    Interval* curr = obj->head;
    while (curr != NULL) {
        Interval* temp = curr;
        curr = curr->next;
        free(temp);
    }
    free(obj);
}