var ParkingSystem = function(big, medium, small) {
    this.slots = [big, medium, small];
};

ParkingSystem.prototype.addCar = function(carType) {
    if (this.slots[carType - 1] > 0) {
        this.slots[carType - 1]--;
        return true;
    } else {
        return false;
    }
};