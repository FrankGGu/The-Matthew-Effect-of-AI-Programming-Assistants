var DataStream = function(value, k) {
    this.value = value;
    this.k = k;
    this.queue = [];
    this.count = 0;
};

DataStream.prototype.consec = function(num) {
    this.queue.push(num);
    if (num === this.value) {
        this.count++;
    } else {
        this.count = 0;
    }
    if (this.queue.length > this.k) {
        const removed = this.queue.shift();
        if (removed === this.value) {
            this.count--;
        }
    }
    return this.count >= this.k;
};