#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *seats;
    int size;
    int n;
} ExamRoom;

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

ExamRoom* examRoomCreate(int n) {
    ExamRoom* obj = (ExamRoom*)malloc(sizeof(ExamRoom));
    obj->seats = (int*)malloc(n * sizeof(int));
    obj->size = 0;
    obj->n = n;
    return obj;
}

int examRoomSeat(ExamRoom* obj) {
    if (obj->size == 0) {
        obj->seats[0] = 0;
        obj->size = 1;
        return 0;
    }

    int dist = obj->seats[0];
    int seat = 0;
    for (int i = 1; i < obj->size; i++) {
        int d = (obj->seats[i] - obj->seats[i - 1]) / 2;
        if (d > dist) {
            dist = d;
            seat = obj->seats[i - 1] + d;
        }
    }

    if (obj->n - 1 - obj->seats[obj->size - 1] > dist) {
        seat = obj->n - 1;
    }

    int i = 0;
    while (i < obj->size && obj->seats[i] < seat) {
        i++;
    }

    for (int j = obj->size; j > i; j--) {
        obj->seats[j] = obj->seats[j - 1];
    }
    obj->seats[i] = seat;
    obj->size++;

    qsort(obj->seats, obj->size, sizeof(int), cmp);
    return seat;
}

void examRoomLeave(ExamRoom* obj, int p) {
    int i = 0;
    while (i < obj->size && obj->seats[i] != p) {
        i++;
    }

    if (i < obj->size) {
        for (int j = i; j < obj->size - 1; j++) {
            obj->seats[j] = obj->seats[j + 1];
        }
        obj->size--;
    }
}

void examRoomFree(ExamRoom* obj) {
    free(obj->seats);
    free(obj);
}