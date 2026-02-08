#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* seats;
    int size;
    int capacity;
} ExamRoom;

ExamRoom* examRoomCreate(int n) {
    ExamRoom* obj = (ExamRoom*)malloc(sizeof(ExamRoom));
    obj->seats = (int*)calloc(n, sizeof(int));
    obj->size = 0;
    obj->capacity = n;
    return obj;
}

int examRoomSeat(ExamRoom* obj) {
    if (obj->size == obj->capacity) return -1;

    int pos = -1;
    int maxDist = -1;

    if (obj->size == 0) {
        pos = 0;
    } else {
        int prev = -1;
        for (int i = 0; i < obj->capacity; i++) {
            if (obj->seats[i] == 1) {
                if (prev == -1) {
                    int dist = i;
                    if (dist > maxDist) {
                        maxDist = dist;
                        pos = 0;
                    }
                } else {
                    int dist = (i - prev) / 2;
                    if (dist > maxDist) {
                        maxDist = dist;
                        pos = prev + dist;
                    }
                }
                prev = i;
            }
        }

        if (prev != -1) {
            int dist = (obj->capacity - 1 - prev);
            if (dist > maxDist) {
                maxDist = dist;
                pos = obj->capacity - 1;
            }
        }
    }

    obj->seats[pos] = 1;
    obj->size++;
    return pos;
}

void examRoomLeave(ExamRoom* obj, int p) {
    if (p >= 0 && p < obj->capacity && obj->seats[p] == 1) {
        obj->seats[p] = 0;
        obj->size--;
    }
}

void examRoomFree(ExamRoom* obj) {
    free(obj->seats);
    free(obj);
}