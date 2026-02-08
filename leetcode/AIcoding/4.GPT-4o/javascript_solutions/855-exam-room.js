class ExamRoom {
    constructor(N) {
        this.N = N;
        this.students = [];
    }

    seat() {
        let maxDist = 0;
        let seat = 0;

        if (this.students.length === 0) {
            seat = 0;
        } else {
            if (this.students[0] > 0) {
                maxDist = this.students[0];
                seat = 0;
            }
            for (let i = 1; i < this.students.length; i++) {
                let dist = Math.floor((this.students[i] - this.students[i - 1]) / 2);
                if (dist > maxDist) {
                    maxDist = dist;
                    seat = this.students[i - 1] + dist;
                }
            }
            if (this.N - 1 - this.students[this.students.length - 1] > maxDist) {
                seat = this.N - 1;
            }
        }

        this.students.push(seat);
        this.students.sort((a, b) => a - b);
        return seat;
    }

    leave(p) {
        const index = this.students.indexOf(p);
        this.students.splice(index, 1);
    }
}