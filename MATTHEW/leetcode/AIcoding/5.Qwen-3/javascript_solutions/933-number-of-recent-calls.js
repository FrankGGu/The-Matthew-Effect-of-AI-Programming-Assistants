var RecentCalls = function() {
    this.queue = [];
};

RecentCalls.prototype.ping = function(t) {
    this.queue.push(t);
    while (this.queue[0] < t - 3000) {
        this.queue.shift();
    }
    return this.queue.length;
};