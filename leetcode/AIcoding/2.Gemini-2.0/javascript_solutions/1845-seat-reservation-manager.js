var SeatManager = function(n) {
    this.seats = [];
    for (let i = 1; i <= n; i++) {
        this.seats.push(i);
    }
    this.seats.sort((a, b) => a - b);
};

SeatManager.prototype.reserve = function() {
    return this.seats.shift();
};

SeatManager.prototype.unreserve = function(seatNumber) {
    let low = 0;
    let high = this.seats.length - 1;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (this.seats[mid] === seatNumber) {
            return;
        } else if (this.seats[mid] < seatNumber) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    this.seats.splice(low, 0, seatNumber);
};