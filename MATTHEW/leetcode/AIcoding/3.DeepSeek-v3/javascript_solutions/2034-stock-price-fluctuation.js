class StockPrice {
    constructor() {
        this.timestamps = new Map();
        this.maxHeap = new MaxPriorityQueue({ priority: (x) => x.price });
        this.minHeap = new MinPriorityQueue({ priority: (x) => x.price });
        this.latestTime = 0;
    }

    update(timestamp, price) {
        this.timestamps.set(timestamp, price);
        this.maxHeap.enqueue({ timestamp, price });
        this.minHeap.enqueue({ timestamp, price });
        if (timestamp > this.latestTime) {
            this.latestTime = timestamp;
        }
    }

    current() {
        return this.timestamps.get(this.latestTime);
    }

    maximum() {
        while (this.maxHeap.front().element.price !== this.timestamps.get(this.maxHeap.front().element.timestamp)) {
            this.maxHeap.dequeue();
        }
        return this.maxHeap.front().element.price;
    }

    minimum() {
        while (this.minHeap.front().element.price !== this.timestamps.get(this.minHeap.front().element.timestamp)) {
            this.minHeap.dequeue();
        }
        return this.minHeap.front().element.price;
    }
}