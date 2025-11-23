var MyCircularQueue = function(k) {
    this.queue = new Array(k);
    this.head = 0;
    this.tail = 0;
    this.size = k;
    this.count = 0;
};

MyCircularQueue.prototype.enQueue = function(value) {
    if (this.isFull()) {
        return false;
    }
    this.queue[this.tail] = value;
    this.tail = (this.tail + 1) % this.size;
    this.count++;
    return true;
};

MyCircularQueue.prototype.deQueue = function() {
    if (this.isEmpty()) {
        return false;
    }
    this.head = (this.head + 1) % this.size;
    this.count--;
    return true;
};

MyCircularQueue.prototype.Front = function() {
    if (this.isEmpty()) {
        return -1;
    }
    return this.queue[this.head];
};

MyCircularQueue.prototype.Rear = function() {
    if (this.isEmpty()) {
        return -1;
    }
    return this.queue[(this.tail - 1 + this.size) % this.size];
};

MyCircularQueue.prototype.isEmpty = function() {
    return this.count === 0;
};

MyCircularQueue.prototype.isFull = function() {
    return this.count === this.size;
};