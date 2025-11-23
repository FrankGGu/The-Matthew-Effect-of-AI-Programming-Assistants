class FrontMiddleBackQueue {
    constructor() {
        this.queue = [];
    }

    pushFront(val) {
        this.queue.unshift(val);
    }

    pushMiddle(val) {
        const mid = Math.floor(this.queue.length / 2);
        this.queue.splice(mid, 0, val);
    }

    pushBack(val) {
        this.queue.push(val);
    }

    popFront() {
        return this.queue.length > 0 ? this.queue.shift() : -1;
    }

    popMiddle() {
        if (this.queue.length === 0) return -1;
        const mid = Math.floor((this.queue.length - 1) / 2);
        return this.queue.splice(mid, 1)[0];
    }

    popBack() {
        return this.queue.length > 0 ? this.queue.pop() : -1;
    }
}