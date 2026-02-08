class ParkingSystem {
    constructor(big, medium, small) {
        this.capacity = [big, medium, small];
        this.occupied = [0, 0, 0];
    }

    addCar(carType) {
        if (this.occupied[carType - 1] < this.capacity[carType - 1]) {
            this.occupied[carType - 1]++;
            return true;
        }
        return false;
    }
}