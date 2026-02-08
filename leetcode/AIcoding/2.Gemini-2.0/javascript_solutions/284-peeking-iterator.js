var PeekingIterator = function(iterator) {
    this.iterator = iterator;
    this.nextElement = null;
    if (this.iterator.hasNext()) {
        this.nextElement = this.iterator.next();
    }
};

PeekingIterator.prototype.peek = function() {
    return this.nextElement;
};

PeekingIterator.prototype.next = function() {
    const result = this.nextElement;
    this.nextElement = null;
    if (this.iterator.hasNext()) {
        this.nextElement = this.iterator.next();
    }
    return result;
};

PeekingIterator.prototype.hasNext = function() {
    return this.nextElement !== null;
};