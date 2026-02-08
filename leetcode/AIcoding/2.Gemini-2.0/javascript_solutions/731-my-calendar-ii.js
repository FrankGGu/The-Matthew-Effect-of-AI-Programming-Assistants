class MyCalendarTwo {
    constructor() {
        this.calendar = [];
        this.overlaps = [];
    }

    book(start, end) {
        for (let [s, e] of this.overlaps) {
            if (start < e && end > s) {
                return false;
            }
        }

        for (let [s, e] of this.calendar) {
            if (start < e && end > s) {
                this.overlaps.push([Math.max(start, s), Math.min(end, e)]);
            }
        }

        this.calendar.push([start, end]);
        return true;
    }
}