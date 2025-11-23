var CustomStack = function(maxSize) {
    this.stack = [];
    this.maxSize = maxSize;
};

CustomStack.prototype.push = function(x) {
    if (this.stack.length < this.maxSize) {
        this.stack.push(x);
    }
};

CustomStack.prototype.pop = function() {
    if (this.stack.length === 0) {
        return -1;
    }
    return this.stack.pop();
};

CustomStack.prototype.increment = function(k, val) {
    const limit = Math.min(k, this.stack.length);
    for (let i = 0; i < limit; i++) {
        this.stack[i] += val;
    }
};