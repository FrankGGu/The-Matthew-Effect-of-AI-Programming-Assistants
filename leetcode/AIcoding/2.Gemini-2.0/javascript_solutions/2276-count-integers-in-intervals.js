class Interval {
    constructor(start, end) {
        this.start = start;
        this.end = end;
    }
}

class CountIntervals {
    constructor() {
        this.intervals = [];
        this.count = 0;
    }

    add(left, right) {
        let newInterval = new Interval(left, right);
        let merged = false;
        let i = 0;

        while (i < this.intervals.length) {
            let currentInterval = this.intervals[i];

            if (newInterval.end < currentInterval.start) {
                this.intervals.splice(i, 0, newInterval);
                this.count += (newInterval.end - newInterval.start + 1);
                merged = true;
                break;
            } else if (newInterval.start > currentInterval.end) {
                i++;
            } else {
                newInterval.start = Math.min(newInterval.start, currentInterval.start);
                newInterval.end = Math.max(newInterval.end, currentInterval.end);
                this.count -= (currentInterval.end - currentInterval.start + 1);
                this.intervals.splice(i, 1);
            }
        }

        if (!merged) {
            this.intervals.push(newInterval);
            this.count += (newInterval.end - newInterval.start + 1);
        }
    }

    count() {
        return this.count;
    }
}