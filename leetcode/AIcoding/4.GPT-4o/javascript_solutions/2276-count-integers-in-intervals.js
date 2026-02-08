class CountIntervals {
    constructor() {
        this.intervals = [];
    }

    add(interval) {
        const [start, end] = interval;
        this.intervals.push([start, end]);
        this.intervals.sort((a, b) => a[0] - b[0]);
        const merged = [];
        for (const [s, e] of this.intervals) {
            if (merged.length === 0 || merged[merged.length - 1][1] < s) {
                merged.push([s, e]);
            } else {
                merged[merged.length - 1][1] = Math.max(merged[merged.length - 1][1], e);
            }
        }
        this.intervals = merged;
    }

    count() {
        let total = 0;
        for (const [s, e] of this.intervals) {
            total += e - s + 1;
        }
        return total;
    }
}