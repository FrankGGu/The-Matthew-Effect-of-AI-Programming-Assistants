var RecentCounter = function() {
    this.calls = [];
};

RecentCounter.prototype.ping = function(t) {
    this.calls.push(t);
    while (this.calls[0] < t - 3000) {
        this.calls.shift();
    }
    return this.calls.length;
};