class MyCalendarTwo {
    constructor() {
        this.intervals = [];
        this.overlaps = [];
    }

    book(start, end) {
        for (const [s, e] of this.overlaps) {
            if (start < e && s < end) return false;
        }

        for (const [s, e] of this.intervals) {
            if (start < e && s < end) {
                this.overlaps.push([Math.max(s, start), Math.min(e, end)]);
            }
        }

        this.intervals.push([start, end]);
        return true;
    }
}