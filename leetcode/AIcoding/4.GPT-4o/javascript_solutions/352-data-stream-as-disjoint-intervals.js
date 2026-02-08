class SummaryRanges {
    constructor() {
        this.intervals = [];
    }

    addNum(val) {
        let start = val, end = val;
        let i = 0;

        while (i < this.intervals.length && this.intervals[i][0] <= val) {
            if (this.intervals[i][0] <= val && this.intervals[i][1] >= val) {
                return; // val is already in an interval
            }
            if (this.intervals[i][1] + 1 === val) {
                start = this.intervals[i][0];
                end = val;
                this.intervals.splice(i, 1);
                i--;
            }
            i++;
        }

        while (i < this.intervals.length && this.intervals[i][0] === val + 1) {
            end = this.intervals[i][1];
            this.intervals.splice(i, 1);
        }

        this.intervals.splice(i, 0, [start, end]);
    }

    getIntervals() {
        return this.intervals;
    }
}