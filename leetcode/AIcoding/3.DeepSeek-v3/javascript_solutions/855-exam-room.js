var ExamRoom = function(N) {
    this.N = N;
    this.students = [];
};

ExamRoom.prototype.seat = function() {
    if (this.students.length === 0) {
        this.students.push(0);
        return 0;
    }

    let maxDist = this.students[0];
    let index = 0;

    for (let i = 1; i < this.students.length; i++) {
        const dist = Math.floor((this.students[i] - this.students[i - 1]) / 2);
        if (dist > maxDist) {
            maxDist = dist;
            index = this.students[i - 1] + dist;
        }
    }

    const lastDist = this.N - 1 - this.students[this.students.length - 1];
    if (lastDist > maxDist) {
        index = this.N - 1;
    }

    let insertPos = this.students.findIndex(p => p > index);
    if (insertPos === -1) {
        this.students.push(index);
    } else {
        this.students.splice(insertPos, 0, index);
    }

    return index;
};

ExamRoom.prototype.leave = function(p) {
    const index = this.students.indexOf(p);
    if (index !== -1) {
        this.students.splice(index, 1);
    }
};