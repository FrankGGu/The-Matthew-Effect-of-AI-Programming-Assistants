var ParkingSystem = function (big, medium, small) {
    this.parking = [0, 0, 0];
    this.capacity = [big, medium, small];
};

ParkingSystem.prototype.addCar = function (carType) {
    if (this.parking[carType - 1] < this.capacity[carType - 1]) {
        this.parking[carType - 1]++;
        return true;
    }
    return false;
};