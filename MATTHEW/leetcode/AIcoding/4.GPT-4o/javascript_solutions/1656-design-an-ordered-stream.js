class OrderedStream {
    constructor(n) {
        this.ptr = 0;
        this.stream = new Array(n);
    }

    insert(idKey, value) {
        this.stream[idKey - 1] = value;
        const result = [];
        while (this.ptr < this.stream.length && this.stream[this.ptr] !== undefined) {
            result.push(this.stream[this.ptr]);
            this.ptr++;
        }
        return result;
    }
}