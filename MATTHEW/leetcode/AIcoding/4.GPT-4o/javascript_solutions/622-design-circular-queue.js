class MyCircularQueue {
    constructor(k) {
        this.size = k;
        this.queue = new Array(k);
        this.front = -1;
        this.rear = -1;
    }

    enQueue(value) {
        if (this.isFull()) return false;
        if (this.isEmpty()) {
            this.front = 0;
        }
        this.rear = (this.rear + 1) % this.size;
        this.queue[this.rear] = value;
        return true;
    }

    deQueue() {
        if (this.isEmpty()) return false;
        if (this.front === this.rear) {
            this.front = -1;
            this.rear = -1;
        } else {
            this.front = (this.front + 1) % this.size;
        }
        return true;
    }

    Front() {
        if (this.isEmpty()) return -1;
        return this.queue[this.front];
    }

    Rear() {
        if (this.isEmpty()) return -1;
        return this.queue[this.rear];
    }

    isEmpty() {
        return this.front === -1;
    }

    isFull() {
        return (this.rear + 1) % this.size === this.front;
    }
}