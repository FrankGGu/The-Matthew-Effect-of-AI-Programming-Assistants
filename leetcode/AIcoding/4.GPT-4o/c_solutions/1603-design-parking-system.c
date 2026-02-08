typedef struct {
    int big, medium, small;
} ParkingSystem;

ParkingSystem* parkingSystemCreate(int big, int medium, int small) {
    ParkingSystem* ps = malloc(sizeof(ParkingSystem));
    ps->big = big;
    ps->medium = medium;
    ps->small = small;
    return ps;
}

bool parkingSystemAddCar(ParkingSystem* obj, int carType) {
    if (carType == 1) {
        if (obj->big > 0) {
            obj->big--;
            return true;
        }
    } else if (carType == 2) {
        if (obj->medium > 0) {
            obj->medium--;
            return true;
        }
    } else if (carType == 3) {
        if (obj->small > 0) {
            obj->small--;
            return true;
        }
    }
    return false;
}

void parkingSystemFree(ParkingSystem* obj) {
    free(obj);
}