var SmallestInfiniteSet = function() {
    this.popped = new Set();
    this.smallest = 1;
};

SmallestInfiniteSet.prototype.popSmallest = function() {
    const res = this.smallest;
    this.popped.add(res);
    while (this.popped.has(this.smallest)) {
        this.smallest++;
    }
    return res;
};

SmallestInfiniteSet.prototype.addBack = function(num) {
    if (this.popped.has(num)) {
        this.popped.delete(num);
        if (num < this.smallest) {
            this.smallest = num;
        }
    }
};