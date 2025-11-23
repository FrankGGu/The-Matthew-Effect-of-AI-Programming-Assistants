class ExamRoom {
    constructor(N) {
        this.N = N;
        this.seats = [];
    }

    seat() {
        if (this.seats.length === 0) {
            this.seats.push(0);
            return 0;
        }

        let dist = this.seats[0];
        let pos = 0;

        for (let i = 0; i < this.seats.length - 1; i++) {
            let d = Math.floor((this.seats[i + 1] - this.seats[i]) / 2);
            if (d > dist) {
                dist = d;
                pos = this.seats[i] + d;
            }
        }

        if (this.N - 1 - this.seats[this.seats.length - 1] > dist) {
            pos = this.N - 1;
        }

        this.seats.push(pos);
        this.seats.sort((a, b) => a - b);
        return pos;
    }

    leave(p) {
        this.seats = this.seats.filter(seat => seat !== p);
    }
}