class FrontMiddleBackQueue {
    constructor() {
        this.arr = [];
    }

    pushFront(val) {
        this.arr.unshift(val);
    }

    pushMiddle(val) {
        const mid = Math.floor(this.arr.length / 2);
        this.arr.splice(mid, 0, val);
    }

    pushBack(val) {
        this.arr.push(val);
    }

    popFront() {
        if (this.arr.length === 0) return -1;
        return this.arr.shift();
    }

    popMiddle() {
        if (this.arr.length === 0) return -1;
        const mid = Math.floor((this.arr.length - 1) / 2);
        return this.arr.splice(mid, 1)[0];
    }

    popBack() {
        if (this.arr.length === 0) return -1;
        return this.arr.pop();
    }
}