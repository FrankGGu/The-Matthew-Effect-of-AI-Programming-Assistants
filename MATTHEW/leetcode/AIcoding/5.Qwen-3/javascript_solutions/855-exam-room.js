var ExamRoom = function(n) {
    this.n = n;
    this.seats = new Set();
};

ExamRoom.prototype.leave = function(p) {
    this.seats.delete(p);
};

ExamRoom.prototype.reserve = function() {
    if (this.seats.size === 0) {
        this.seats.add(0);
        return 0;
    }

    let maxDist = 0;
    let res = 0;
    let prev = -1;

    for (let seat of this.seats) {
        if (prev === -1) {
            const dist = seat;
            if (dist > maxDist) {
                maxDist = dist;
                res = 0;
            }
        } else {
            const dist = Math.floor((seat - prev) / 2);
            if (dist > maxDist) {
                maxDist = dist;
                res = prev + dist;
            }
        }
        prev = seat;
    }

    const lastDist = this.n - 1 - prev;
    if (lastDist > maxDist) {
        res = this.n - 1;
    }

    this.seats.add(res);
    return res;
};