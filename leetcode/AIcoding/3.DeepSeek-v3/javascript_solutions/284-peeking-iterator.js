var PeekingIterator = function(iterator) {
    this.iterator = iterator;
    this.peekedValue = null;
};

PeekingIterator.prototype.peek = function() {
    if (this.peekedValue === null) {
        this.peekedValue = this.iterator.next();
    }
    return this.peekedValue;
};

PeekingIterator.prototype.next = function() {
    if (this.peekedValue !== null) {
        const value = this.peekedValue;
        this.peekedValue = null;
        return value;
    }
    return this.iterator.next();
};

PeekingIterator.prototype.hasNext = function() {
    return this.peekedValue !== null || this.iterator.hasNext();
};