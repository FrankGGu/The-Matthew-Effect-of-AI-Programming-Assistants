class MyCalendar {
    constructor() {
        this.events = [];
    }

    book(start, end) {
        for (const [s, e] of this.events) {
            if (start < e && end > s) {
                return false;
            }
        }
        this.events.push([start, end]);
        return true;
    }
}