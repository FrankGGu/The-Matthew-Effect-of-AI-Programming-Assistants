class ParkingSystem {
    constructor(big, medium, small) {
        this.slots = [big, medium, small];
    }

    addCar(carType) {
        if (this.slots[carType - 1] > 0) {
            this.slots[carType - 1]--;
            return true;
        }
        return false;
    }
}