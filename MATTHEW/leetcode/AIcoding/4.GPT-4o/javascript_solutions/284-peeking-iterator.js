class Iterator {
    constructor(nums) {
        this.nums = nums;
        this.index = 0;
    }

    hasNext() {
        return this.index < this.nums.length;
    }

    next() {
        return this.nums[this.index++];
    }
}

class PeekingIterator {
    constructor(iterator) {
        this.iterator = iterator;
        this.peeked = false;
        this.peekedValue = null;
    }

    peek() {
        if (!this.peeked) {
            this.peekedValue = this.iterator.next();
            this.peeked = true;
        }
        return this.peekedValue;
    }

    next() {
        if (this.peeked) {
            this.peeked = false;
            return this.peekedValue;
        }
        return this.iterator.next();
    }

    hasNext() {
        return this.peeked || this.iterator.hasNext();
    }
}