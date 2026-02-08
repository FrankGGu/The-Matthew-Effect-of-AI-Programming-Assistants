var FrontMiddleBackQueue = function() {
    this.left = [];
    this.right = [];
};

FrontMiddleBackQueue.prototype.balance = function() {
    if (this.left.length > this.right.length) {
        this.right.unshift(this.left.pop());
    } else if (this.right.length > this.left.length + 1) {
        this.left.push(this.right.shift());
    }
};

FrontMiddleBackQueue.prototype.pushFront = function(val) {
    this.left.unshift(val);
    this.balance();
};

FrontMiddleBackQueue.prototype.pushMiddle = function(val) {
    if (this.left.length === this.right.length) {
        this.right.unshift(val);
    } else {
        this.left.push(val);
    }
    this.balance();
};

FrontMiddleBackQueue.prototype.pushBack = function(val) {
    this.right.push(val);
    this.balance();
};

FrontMiddleBackQueue.prototype.popFront = function() {
    if (this.isEmpty()) return -1;
    let val;
    if (this.left.length === 0) {
        val = this.right.shift();
    } else {
        val = this.left.shift();
    }
    this.balance();
    return val;
};

FrontMiddleBackQueue.prototype.popMiddle = function() {
    if (this.isEmpty()) return -1;
    let val;
    if (this.left.length === this.right.length) {
        val = this.left.pop();
    } else {
        val = this.right.shift();
    }
    this.balance();
    return val;
};

FrontMiddleBackQueue.prototype.popBack = function() {
    if (this.isEmpty()) return -1;
    const val = this.right.pop();
    this.balance();
    return val;
};

FrontMiddleBackQueue.prototype.isEmpty = function() {
    return this.left.length === 0 && this.right.length === 0;
};