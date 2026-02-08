class ParkingSystem {
private:
    int slots[3];
public:
    ParkingSystem(int big, int medium, int small) {
        slots[0] = big;
        slots[1] = medium;
        slots[2] = small;
    }

    bool addCar(int carType) {
        if (slots[carType - 1] > 0) {
            slots[carType - 1]--;
            return true;
        } else {
            return false;
        }
    }
};