var OrderedStream = function(n) {
    this.data = new Array(n).fill(null);
    this.ptr = 0;
};

OrderedStream.prototype.insert = function(id, value) {
    this.data[id - 1] = value;
    const result = [];
    while (this.ptr < this.data.length && this.data[this.ptr] !== null) {
        result.push(this.data[this.ptr]);
        this.ptr++;
    }
    return result;
};