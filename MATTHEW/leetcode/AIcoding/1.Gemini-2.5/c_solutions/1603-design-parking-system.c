#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int big_slots;
    int medium_slots;
    int small_slots;
} ParkingSystem;

ParkingSystem* parkingSystemCreate(int big, int medium, int small) {
    ParkingSystem* obj = (ParkingSystem*) malloc(sizeof(ParkingSystem));
    if (obj == NULL) {
        return NULL;
    }
    obj->big_slots = big;
    obj->medium_slots = medium;
    obj->small_slots = small;
    return obj;
}

bool parkingSystemAddCar(ParkingSystem* obj, int carType) {
    switch (carType) {
        case 1: // Big car
            if (obj->big_slots > 0) {
                obj->big_slots--;
                return true;
            }
            return false;
        case 2: // Medium car
            if (obj->medium_slots > 0) {
                obj->medium_slots--;
                return true;
            }
            return false;
        case 3: // Small car
            if (obj->small_slots > 0) {
                obj->small_slots--;
                return true;
            }
            return false;
        default:
            return false;
    }
}

void parkingSystemFree(ParkingSystem* obj) {
    free(obj);
}