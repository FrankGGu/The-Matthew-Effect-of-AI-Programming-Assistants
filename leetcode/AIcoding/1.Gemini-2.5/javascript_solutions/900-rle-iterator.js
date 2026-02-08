var RLEIterator = function(A) {
    this.rle = A;
    this.rleIndex = 0; // Points to the count in the RLE array
};

RLEIterator.prototype.next = function(n) {
    while (this.rleIndex < this.rle.length) {
        let currentCount = this.rle[this.rleIndex];
        let currentValue = this.rle[this.rleIndex + 1];

        if (n <= currentCount) {
            // If n elements can be satisfied by the current segment
            this.rle[this.rleIndex] -= n; // Decrement the count
            return currentValue;
        } else {
            // If n elements cannot be fully satisfied by the current segment
            // Consume the entire current segment
            n -= currentCount;
            this.rleIndex += 2; // Move to the next segment (skip count and value)
        }
    }
    // If we reach here, it means we ran out of segments
    return -1;
};