class RecentCounter {
    constructor() {
        this.calls = [];
    }

    ping(t) {
        this.calls.push(t);
        while (this.calls[0] < t - 3000) {
            this.calls.shift();
        }
        return this.calls.length;
    }
}