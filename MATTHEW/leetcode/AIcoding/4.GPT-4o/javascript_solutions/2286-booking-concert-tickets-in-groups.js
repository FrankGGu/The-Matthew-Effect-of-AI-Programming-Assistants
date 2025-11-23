class BookMyShow {
    constructor(n, m) {
        this.rows = n;
        this.cols = m;
        this.availableSeats = Array(n).fill(0).map(() => m);
    }

    gather(maxRow, maxCol) {
        for (let row = 0; row <= maxRow; row++) {
            if (this.availableSeats[row] >= maxCol) {
                this.availableSeats[row] -= maxCol;
                return [row, this.cols - this.availableSeats[row] - maxCol];
            }
        }
        return [-1, -1];
    }

    scatter(k, maxRow) {
        let seats = [];
        for (let row = 0; row <= maxRow; row++) {
            while (this.availableSeats[row] > 0 && k > 0) {
                seats.push(row);
                this.availableSeats[row]--;
                k--;
            }
            if (k === 0) break;
        }
        return seats.length === k ? seats : [];
    }
}