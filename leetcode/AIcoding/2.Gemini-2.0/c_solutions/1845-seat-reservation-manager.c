#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *seats;
    int size;
    int next;
} SeatManager;

SeatManager* seatManagerCreate(int n) {
    SeatManager* obj = (SeatManager*)malloc(sizeof(SeatManager));
    obj->seats = (int*)malloc(n * sizeof(int));
    obj->size = n;
    obj->next = 1;
    for (int i = 0; i < n; i++) {
        obj->seats[i] = 0;
    }
    return obj;
}

int seatManagerReserve(SeatManager* obj) {
    int seat = obj->next;
    obj->seats[seat - 1] = 1;

    int min_unreserved = obj->size + 1;
    for(int i = 0; i < obj->size; i++) {
        if(obj->seats[i] == 0) {
            min_unreserved = i + 1;
            break;
        }
    }
    obj->next = min_unreserved;

    for(int i = 0; i < obj->size; i++) {
        if(obj->seats[i] == 0 && i + 1 < obj->next) {
            obj->next = i + 1;
        }
    }

    return seat;
}

void seatManagerUnreserve(SeatManager* obj, int seatNumber) {
    obj->seats[seatNumber - 1] = 0;
    if (seatNumber < obj->next) {
        obj->next = seatNumber;
    }
}

void seatManagerFree(SeatManager* obj) {
    free(obj->seats);
    free(obj);
}