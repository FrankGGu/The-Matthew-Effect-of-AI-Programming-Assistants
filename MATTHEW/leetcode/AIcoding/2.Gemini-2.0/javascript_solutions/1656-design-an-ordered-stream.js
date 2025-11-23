var OrderedStream = function(n) {
    this.stream = new Array(n + 1);
    this.ptr = 1;
};

OrderedStream.prototype.insert = function(idKey, value) {
    this.stream[idKey] = value;
    let result = [];
    while (this.stream[this.ptr]) {
        result.push(this.stream[this.ptr]);
        this.ptr++;
    }
    return result;
};