var SummaryRanges = function() {
    this.intervals = [];
};

SummaryRanges.prototype.addNum = function(value) {
    let left = 0, right = this.intervals.length - 1;
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const [start, end] = this.intervals[mid];
        if (value >= start && value <= end) {
            return;
        } else if (value < start) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    const pos = left;
    this.intervals.splice(pos, 0, [value, value]);

    if (pos > 0 && this.intervals[pos - 1][1] + 1 === this.intervals[pos][0]) {
        this.intervals[pos - 1][1] = this.intervals[pos][1];
        this.intervals.splice(pos, 1);
        pos--;
    }

    if (pos < this.intervals.length - 1 && this.intervals[pos][1] + 1 === this.intervals[pos + 1][0]) {
        this.intervals[pos][1] = this.intervals[pos + 1][1];
        this.intervals.splice(pos + 1, 1);
    }
};

SummaryRanges.prototype.getIntervals = function() {
    return this.intervals;
};