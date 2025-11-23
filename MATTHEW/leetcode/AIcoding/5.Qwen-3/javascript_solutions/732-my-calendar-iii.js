var MyCalendarThree = function() {
    this.timeline = [];
};

MyCalendarThree.prototype.book = function(start, end) {
    this.timeline.push([start, 1]);
    this.timeline.push([end, -1]);
    this.timeline.sort((a, b) => a[0] !== b[0] ? a[0] - b[0] : a[1] - b[1]);

    let maxK = 0;
    let currentK = 0;

    for (let i = 0; i < this.timeline.length; i++) {
        currentK += this.timeline[i][1];
        maxK = Math.max(maxK, currentK);
    }

    return maxK;
};