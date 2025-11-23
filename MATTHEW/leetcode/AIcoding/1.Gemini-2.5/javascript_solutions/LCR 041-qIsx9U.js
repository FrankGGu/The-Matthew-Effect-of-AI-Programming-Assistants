var MovingAverage = function(size) {
    this.queue = [];
    this.sum = 0;
    this.maxSize = size;
};

MovingAverage.prototype.next = function(val) {
    this.queue.push(val);
    this.sum += val;

    if (this.queue.length > this.maxSize) {
        let oldestVal = this.queue.shift();
        this.sum -= oldestVal;
    }

    return this.sum / this.queue.length;
};