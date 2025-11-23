class MyCalendarThree {
    constructor() {
        this.timeline = new Map();
    }

    book(start, end) {
        this.timeline.set(start, (this.timeline.get(start) || 0) + 1);
        this.timeline.set(end, (this.timeline.get(end) || 0) - 1);

        let maxBookings = 0;
        let currentBookings = 0;

        for (const count of this.timeline.values()) {
            currentBookings += count;
            maxBookings = Math.max(maxBookings, currentBookings);
        }

        return maxBookings;
    }
}