var MyCircularDeque = function(k) {
    this.capacity = k;
    this.front = 0;
    this.rear = 0;
    this.size = 0;
    this.data = new Array(k).fill(0);
};

MyCircularDeque.prototype.insertFront = function(value) {
    if (this.isFull()) return false;
    this.front = (this.front - 1 + this.capacity) % this.capacity;
    this.data[this.front] = value;
    this.size++;
    return true;
};

MyCircularDeque.prototype.insertLast = function(value) {
    if (this.isFull()) return false;
    this.data[this.rear] = value;
    this.rear = (this.rear + 1) % this.capacity;
    this.size++;
    return true;
};

MyCircularDeque.prototype.deleteFront = function() {
    if (this.isEmpty()) return false;
    this.front = (this.front + 1) % this.capacity;
    this.size--;
    return true;
};

MyCircularDeque.prototype.deleteLast = function() {
    if (this.isEmpty()) return false;
    this.rear = (this.rear - 1 + this.capacity) % this.capacity;
    this.size--;
    return true;
};

MyCircularDeque.prototype.getFront = function() {
    if (this.isEmpty()) return -1;
    return this.data[this.front];
};

MyCircularDeque.prototype.getRear = function() {
    if (this.isEmpty()) return -1;
    return this.data[(this.rear - 1 + this.capacity) % this.capacity];
};

MyCircularDeque.prototype.isEmpty = function() {
    return this.size === 0;
};

MyCircularDeque.prototype.isFull = function() {
    return this.size === this.capacity;
};