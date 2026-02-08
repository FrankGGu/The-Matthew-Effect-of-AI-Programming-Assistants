var MyCalendarThree = function() {
    this.timeline = new Map();
};

MyCalendarThree.prototype.book = function(start, end) {
    this.timeline.set(start, (this.timeline.get(start) || 0) + 1);
    this.timeline.set(end, (this.timeline.get(end) || 0) - 1);

    let maxOverlap = 0;
    let currentOverlap = 0;

    const sortedTimes = Array.from(this.timeline.keys()).sort((a, b) => a - b);

    for (const time of sortedTimes) {
        currentOverlap += this.timeline.get(time);
        maxOverlap = Math.max(maxOverlap, currentOverlap);
    }

    return maxOverlap;
};