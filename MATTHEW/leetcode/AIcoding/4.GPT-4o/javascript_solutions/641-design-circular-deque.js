class MyCircularDeque {
    constructor(k) {
        this.size = k;
        this deque = new Array(k);
        this.head = -1;
        this.tail = -1;
    }

    insertFront(value) {
        if (this.isFull()) return false;
        if (this.isEmpty()) {
            this.head = 0;
            this.tail = 0;
        } else {
            this.head = (this.head - 1 + this.size) % this.size;
        }
        this.deque[this.head] = value;
        return true;
    }

    insertLast(value) {
        if (this.isFull()) return false;
        if (this.isEmpty()) {
            this.head = 0;
            this.tail = 0;
        } else {
            this.tail = (this.tail + 1) % this.size;
        }
        this.deque[this.tail] = value;
        return true;
    }

    deleteFront() {
        if (this.isEmpty()) return false;
        if (this.head === this.tail) {
            this.head = -1;
            this.tail = -1;
        } else {
            this.head = (this.head + 1) % this.size;
        }
        return true;
    }

    deleteLast() {
        if (this.isEmpty()) return false;
        if (this.head === this.tail) {
            this.head = -1;
            this.tail = -1;
        } else {
            this.tail = (this.tail - 1 + this.size) % this.size;
        }
        return true;
    }

    getFront() {
        if (this.isEmpty()) return -1;
        return this.deque[this.head];
    }

    getRear() {
        if (this.isEmpty()) return -1;
        return this.deque[this.tail];
    }

    isEmpty() {
        return this.head === -1;
    }

    isFull() {
        return (this.tail + 1) % this.size === this.head;
    }
}