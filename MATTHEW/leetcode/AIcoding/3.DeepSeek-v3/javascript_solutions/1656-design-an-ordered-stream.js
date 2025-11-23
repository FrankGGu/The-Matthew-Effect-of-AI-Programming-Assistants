var OrderedStream = function(n) {
    this.stream = new Array(n + 1).fill(null);
    this.ptr = 1;
};

OrderedStream.prototype.insert = function(idKey, value) {
    this.stream[idKey] = value;
    const result = [];
    while (this.ptr < this.stream.length && this.stream[this.ptr] !== null) {
        result.push(this.stream[this.ptr]);
        this.ptr++;
    }
    return result;
};