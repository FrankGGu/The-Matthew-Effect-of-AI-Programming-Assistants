class MedianFinder {
    constructor() {
        this.lower = new MaxPriorityQueue();
        this.upper = new MinPriorityQueue();
    }

    addNum(num) {
        this.lower.enqueue(num);
        this.upper.enqueue(this.lower.dequeue().element);

        if (this.lower.size() < this.upper.size()) {
            this.lower.enqueue(this.upper.dequeue().element);
        }
    }

    findMedian() {
        if (this.lower.size() > this.upper.size()) {
            return this.lower.front().element;
        }
        return (this.lower.front().element + this.upper.front().element) / 2;
    }
}