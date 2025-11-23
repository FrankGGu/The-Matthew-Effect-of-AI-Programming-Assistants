var FrontMiddleBackQueue = function() {
    this.queue = [];
};

FrontMiddleBackQueue.prototype.pushFront = function(val) {
    this.queue.unshift(val);
};

FrontMiddleBackQueue.prototype.pushMiddle = function(val) {
    const mid = Math.floor(this.queue.length / 2);
    this.queue.splice(mid, 0, val);
};

FrontMiddleBackQueue.prototype.pushBack = function(val) {
    this.queue.push(val);
};

FrontMiddleBackQueue.prototype.popFront = function() {
    return this.queue.length ? this.queue.shift() : -1;
};

FrontMiddleBackQueue.prototype.popMiddle = function() {
    if (this.queue.length === 0) return -1;
    const mid = Math.floor(this.queue.length / 2);
    return this.queue.splice(mid, 1)[0];
};

FrontMiddleBackQueue.prototype.popBack = function() {
    return this.queue.length ? this.queue.pop() : -1;
};