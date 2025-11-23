var RLEIterator = function(encoding) {
    this.encoding = encoding;
    this.index = 0;
};

RLEIterator.prototype.next = function(n) {
    while (this.index < this.encoding.length) {
        if (n > this.encoding[this.index]) {
            n -= this.encoding[this.index];
            this.index += 2;
        } else {
            this.encoding[this.index] -= n;
            return this.encoding[this.index + 1];
        }
    }
    return -1;
};