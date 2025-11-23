#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int big;
    int medium;
    int small;
} ParkingSystem;

ParkingSystem* parkingSystemCreate(int big, int medium, int small) {
    ParkingSystem* obj = (ParkingSystem*)malloc(sizeof(ParkingSystem));
    obj->big = big;
    obj->medium = medium;
    obj->small = small;
    return obj;
}

bool parkingSystemAddCar(ParkingSystem* obj, int carType) {
    if (carType == 1 && obj->big > 0) {
        obj->big--;
        return true;
    } else if (carType == 2 && obj->medium > 0) {
        obj->medium--;
        return true;
    } else if (carType == 3 && obj->small > 0) {
        obj->small--;
        return true;
    }
    return false;
}

void parkingSystemFree(ParkingSystem* obj) {
    free(obj);
}