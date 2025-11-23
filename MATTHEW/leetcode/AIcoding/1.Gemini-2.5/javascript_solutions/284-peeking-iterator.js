class PeekingIterator {
    constructor(iterator) {
        this.iterator = iterator;
        this.peekedVal = null;
        this.hasPeekedVal = false;
    }

    peek() {
        if (!this.hasPeekedVal) {
            this.peekedVal = this.iterator.next();
            this.hasPeekedVal = true;
        }
        return this.peekedVal;
    }

    next() {
        if (this.hasPeekedVal) {
            let result = this.peekedVal;
            this.peekedVal = null;
            this.hasPeekedVal = false;
            return result;
        } else {
            return this.iterator.next();
        }
    }

    hasNext() {
        return this.hasPeekedVal || this.iterator.hasNext();
    }
}