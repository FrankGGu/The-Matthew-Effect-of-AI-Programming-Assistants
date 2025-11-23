class SmallestInfiniteSet {
    constructor() {
        this.present = new Set();
        this.smallest = 1;
    }

    popSmallest() {
        if (this.present.size > 0) {
            let min = Math.min(...this.present);
            this.present.delete(min);
            return min;
        } else {
            let temp = this.smallest;
            this.smallest++;
            return temp;
        }
    }

    addBack(num) {
        if (num < this.smallest && !this.present.has(num)) {
            this.present.add(num);
        }
    }
}