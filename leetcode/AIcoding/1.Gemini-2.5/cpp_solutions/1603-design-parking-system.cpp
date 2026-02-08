class ParkingSystem {
private:
    int bigSlots;
    int mediumSlots;
    int smallSlots;
public:
    ParkingSystem(int big, int medium, int small) {
        bigSlots = big;
        mediumSlots = medium;
        smallSlots = small;
    }

    bool addCar(int carType) {
        if (carType == 1) { // Big car
            if (bigSlots > 0) {
                bigSlots--;
                return true;
            }
        } else if (carType == 2) { // Medium car
            if (mediumSlots > 0) {
                mediumSlots--;
                return true;
            }
        } else if (carType == 3) { // Small car
            if (smallSlots > 0) {
                smallSlots--;
                return true;
            }
        }
        return false;
    }
};