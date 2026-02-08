var ParkingSystem = function(big, medium, small) {
    this.spaces = [0, big, medium, small];
};

ParkingSystem.prototype.addCar = function(carType) {
    if (this.spaces[carType] > 0) {
        this.spaces[carType]--;
        return true;
    }
    return false;
};