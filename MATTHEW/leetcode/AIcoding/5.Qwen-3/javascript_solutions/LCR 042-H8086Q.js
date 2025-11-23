var RecentCounter = function() {
    this.queue = [];
};

RecentCounter.prototype.ping = function(t) {
    while (this.queue.length > 0 && this.queue[0] < t - 3000) {
        this.queue.shift();
    }
    this.queue.push(t);
    return this.queue.length;
};