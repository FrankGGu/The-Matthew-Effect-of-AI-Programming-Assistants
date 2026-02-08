class ParkingSystem {
public:
    vector<int> capacity;
    vector<int> count;

    ParkingSystem(int big, int medium, int small) {
        capacity = {big, medium, small};
        count = {0, 0, 0};
    }

    bool addCar(int carType) {
        if (count[carType - 1] < capacity[carType - 1]) {
            count[carType - 1]++;
            return true;
        }
        return false;
    }
};