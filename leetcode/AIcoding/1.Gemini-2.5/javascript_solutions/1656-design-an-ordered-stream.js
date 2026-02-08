var OrderedStream = function(n) {
    this.stream = new Array(n).fill(undefined);
    this.ptr = 1;
    this.n = n;
};

OrderedStream.prototype.insert = function(idKey, value) {
    this.stream[idKey - 1] = value;
    let result = [];

    if (idKey === this.ptr) {
        while (this.ptr <= this.n && this.stream[this.ptr - 1] !== undefined) {
            result.push(this.stream[this.ptr - 1]);
            this.ptr++;
        }
    }

    return result;
};