#include <stdlib.h>

typedef struct {
    int *seats;
    int size;
} SeatManager;

SeatManager* seatManagerCreate(int n) {
    SeatManager *manager = (SeatManager *)malloc(sizeof(SeatManager));
    manager->seats = (int *)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        manager->seats[i] = i + 1;
    }
    manager->size = n;
    return manager;
}

int seatManagerReserve(SeatManager* obj) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->seats[i] != 0) {
            int seat = obj->seats[i];
            obj->seats[i] = 0;
            return seat;
        }
    }
    return -1;
}

void seatManagerUnreserve(SeatManager* obj, int seatNumber) {
    obj->seats[seatNumber - 1] = seatNumber;
}

void seatManagerFree(SeatManager* obj) {
    free(obj->seats);
    free(obj);
}