var MyCircularQueue = function(k) {
    this.queue = new Array(k);
    this.head = -1;
    this.tail = -1;
    this.size = k;
};

MyCircularQueue.prototype.enQueue = function(value) {
    if (this.isFull()) {
        return false;
    }
    if (this.isEmpty()) {
        this.head = 0;
    }
    this.tail = (this.tail + 1) % this.size;
    this.queue[this.tail] = value;
    return true;
};

MyCircularQueue.prototype.deQueue = function() {
    if (this.isEmpty()) {
        return false;
    }
    if (this.head === this.tail) {
        this.head = -1;
        this.tail = -1;
    } else {
        this.head = (this.head + 1) % this.size;
    }
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
    return this.queue[this.tail];
};

MyCircularQueue.prototype.isEmpty = function() {
    return this.head === -1;
};

MyCircularQueue.prototype.isFull = function() {
    return (this.tail + 1) % this.size === this.head;
};