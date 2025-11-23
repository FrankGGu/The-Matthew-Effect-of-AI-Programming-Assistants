#include <stdio.h>
#include <stdlib.h>

struct ExamRoom {
    int *seats;
    int size;
    int count;
};

struct ExamRoom* examRoomCreate(int n) {
    struct ExamRoom* room = malloc(sizeof(struct ExamRoom));
    room->seats = malloc(n * sizeof(int));
    room->size = n;
    room->count = 0;
    return room;
}

int examRoomSeat(struct ExamRoom* obj) {
    if (obj->count == 0) {
        obj->seats[obj->count++] = 0;
        return 0;
    }

    int maxDist = obj->seats[0];
    int seat = 0;

    for (int i = 1; i < obj->count; i++) {
        int dist = (obj->seats[i] - obj->seats[i - 1]) / 2;
        if (dist > maxDist) {
            maxDist = dist;
            seat = obj->seats[i - 1] + dist;
        }
    }

    if (obj->size - 1 - obj->seats[obj->count - 1] > maxDist) {
        seat = obj->size - 1;
    }

    obj->seats[obj->count++] = seat;

    for (int i = obj->count - 1; i > 0; i--) {
        if (obj->seats[i] < obj->seats[i - 1]) {
            int temp = obj->seats[i];
            obj->seats[i] = obj->seats[i - 1];
            obj->seats[i - 1] = temp;
        }
    }

    return seat;
}

void examRoomLeave(struct ExamRoom* obj, int p) {
    for (int i = 0; i < obj->count; i++) {
        if (obj->seats[i] == p) {
            for (int j = i; j < obj->count - 1; j++) {
                obj->seats[j] = obj->seats[j + 1];
            }
            obj->count--;
            break;
        }
    }
}

void examRoomFree(struct ExamRoom* obj) {
    free(obj->seats);
    free(obj);
}