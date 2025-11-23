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
    if (this.queue.length === 0) {
        return -1;
    }
    return this.queue.shift();
};

FrontMiddleBackQueue.prototype.popMiddle = function() {
    if (this.queue.length === 0) {
        return -1;
    }
    const mid = Math.floor((this.queue.length - 1) / 2);
    return this.queue.splice(mid, 1)[0];
};

FrontMiddleBackQueue.prototype.popBack = function() {
    if (this.queue.length === 0) {
        return -1;
    }
    return this.queue.pop();
};