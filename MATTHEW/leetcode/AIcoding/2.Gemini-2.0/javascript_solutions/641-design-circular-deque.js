var MyCircularDeque = function(k) {
    this.deque = new Array(k);
    this.head = 0;
    this.tail = 0;
    this.size = 0;
    this.capacity = k;
};

MyCircularDeque.prototype.insertFront = function(value) {
    if (this.isFull()) {
        return false;
    }
    this.head = (this.head - 1 + this.capacity) % this.capacity;
    this.deque[this.head] = value;
    this.size++;
    return true;
};

MyCircularDeque.prototype.insertLast = function(value) {
    if (this.isFull()) {
        return false;
    }
    this.deque[this.tail] = value;
    this.tail = (this.tail + 1) % this.capacity;
    this.size++;
    return true;
};

MyCircularDeque.prototype.deleteFront = function() {
    if (this.isEmpty()) {
        return false;
    }
    this.head = (this.head + 1) % this.capacity;
    this.size--;
    return true;
};

MyCircularDeque.prototype.deleteLast = function() {
    if (this.isEmpty()) {
        return false;
    }
    this.tail = (this.tail - 1 + this.capacity) % this.capacity;
    this.size--;
    return true;
};

MyCircularDeque.prototype.getFront = function() {
    if (this.isEmpty()) {
        return -1;
    }
    return this.deque[this.head];
};

MyCircularDeque.prototype.getRear = function() {
    if (this.isEmpty()) {
        return -1;
    }
    return this.deque[(this.tail - 1 + this.capacity) % this.capacity];
};

MyCircularDeque.prototype.isEmpty = function() {
    return this.size === 0;
};

MyCircularDeque.prototype.isFull = function() {
    return this.size === this.capacity;
};