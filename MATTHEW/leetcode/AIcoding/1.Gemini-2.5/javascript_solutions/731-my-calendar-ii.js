var MyCalendarTwo = function() {
    this.calendar = [];
    this.overlaps = [];
};

MyCalendarTwo.prototype.book = function(start, end) {
    const hasOverlap = (s1, e1, s2, e2) => s1 < e2 && s2 < e1;

    for (let i = 0; i < this.overlaps.length; i++) {
        const [os, oe] = this.overlaps[i];
        if (hasOverlap(start, end, os, oe)) {
            return false;
        }
    }

    for (let i = 0; i < this.calendar.length; i++) {
        const [cs, ce] = this.calendar[i];
        if (hasOverlap(start, end, cs, ce)) {
            this.overlaps.push([Math.max(start, cs), Math.min(end, ce)]);
        }
    }

    this.calendar.push([start, end]);
    return true;
};