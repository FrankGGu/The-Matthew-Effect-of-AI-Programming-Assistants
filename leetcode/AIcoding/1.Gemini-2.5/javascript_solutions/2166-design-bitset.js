var Bitset = function(size) {
    this.arr = new new Uint8Array(size);
    this.flippedArr = new Uint8Array(size);
    this.flippedArr.fill(1);
    this.size = size;
    this.countOnes = 0;
};

Bitset.prototype.fix = function(idx) {
    if (this.arr[idx] === 0) {
        this.arr[idx] = 1;
        this.flippedArr[idx] = 0;
        this.countOnes++;
    }
};

Bitset.prototype.unfix = function(idx) {
    if (this.arr[idx] === 1) {
        this.arr[idx] = 0;
        this.flippedArr[idx] = 1;
        this.countOnes--;
    }
};

Bitset.prototype.flip = function() {
    [this.arr, this.flippedArr] = [this.flippedArr, this.arr];
    this.countOnes = this.size - this.countOnes;
};

Bitset.prototype.all = function() {
    return this.countOnes === this.size;
};

Bitset.prototype.one = function() {
    return this.countOnes > 0;
};

Bitset.prototype.count = function() {
    return this.countOnes;
};

Bitset.prototype.toString = function() {
    return this.arr.join('');
};