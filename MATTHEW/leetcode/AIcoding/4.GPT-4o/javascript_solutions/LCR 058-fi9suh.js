class MyCalendar {
    constructor() {
        this.intervals = [];
    }

    book(start, end) {
        for (const [s, e] of this.intervals) {
            if (start < e && end > s) {
                return false;
            }
        }
        this.intervals.push([start, end]);
        return true;
    }
}