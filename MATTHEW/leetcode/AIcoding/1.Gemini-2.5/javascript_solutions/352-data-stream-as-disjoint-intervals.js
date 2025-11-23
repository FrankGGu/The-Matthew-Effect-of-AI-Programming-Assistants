var SummaryRanges = function() {
    this.nums = new Set();
};

SummaryRanges.prototype.addNum = function(val) {
    this.nums.add(val);
};

SummaryRanges.prototype.getIntervals = function() {
    if (this.nums.size === 0) {
        return [];
    }

    const sortedNums = Array.from(this.nums).sort((a, b) => a - b);
    const intervals = [];

    let currentStart = sortedNums[0];
    let currentEnd = sortedNums[0];

    for (let i = 1; i < sortedNums.length; i++) {
        const num = sortedNums[i];
        if (num === currentEnd + 1) {
            currentEnd = num;
        } else {
            intervals.push([currentStart, currentEnd]);
            currentStart = num;
            currentEnd = num;
        }
    }
    intervals.push([currentStart, currentEnd]);

    return intervals;
};