class MinHeap {
    constructor(comparator = (a, b) => a - b) {
        this.heap = [];
        this.comparator = comparator;
    }

    size() {
        return this.heap.length;
    }

    isEmpty() {
        return this.size() === 0;
    }

    peek() {
        return this.heap[0];
    }

    add(value) {
        this.heap.push(value);
        this._bubbleUp(this.heap.length - 1);
    }

    extractMin() {
        if (this.isEmpty()) return undefined;
        if (this.size() === 1) return this.heap.pop();

        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return min;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.comparator(this.heap[index], this.heap[parentIndex]) < 0) {
                [this.heap[index], this.heap[parentIndex]] = [this.heap[parentIndex], this.heap[index]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _bubbleDown(index) {
        const lastIndex = this.heap.length - 1;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex <= lastIndex && this.comparator(this.heap[leftChildIndex], this.heap[smallestIndex]) < 0) {
                smallestIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this.comparator(this.heap[rightChildIndex], this.heap[smallestIndex]) < 0) {
                smallestIndex = rightChildIndex;
            }

            if (smallestIndex !== index) {
                [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
                index = smallestIndex;
            } else {
                break;
            }
        }
    }
}

var avoidFlood = function(rains) {
    const n = rains.length;
    const ans = new Array(n).fill(1); // Default to drying lake 1 on dry days

    // Precompute next rain day for each lake
    const nextRain = new Array(n);
    const lastSeen = new Map(); // lakeId -> index
    for (let i = n - 1; i >= 0; i--) {
        const lakeId = rains[i];
        if (lakeId > 0) {
            if (lastSeen.has(lakeId)) {
                nextRain[i] = lastSeen.get(lakeId);
            } else {
                nextRain[i] = Infinity; // This lake won't rain again
            }
            lastSeen.set(lakeId, i);
        }
    }

    // Map to track lakes currently full: lakeId -> dayIndex when it became full
    const fullLakes = new Map();
    // Min-heap to store [nextRainDayIndex, lakeId] for lakes that are currently full
    // Prioritize by nextRainDayIndex (ascending)
    const dryableLakesHeap = new MinHeap((a, b) => a[0] - b[0]);

    for (let i = 0; i < n; i++) {
        const lakeId = rains[i];

        if (lakeId > 0) { // Rainy day
            ans[i] = -1; // No drying on a rainy day
            if (fullLakes.has(lakeId)) {
                // This lake is already full and it's raining again. Flood!
                return [];
            }
            fullLakes.set(lakeId, i); // Mark lake as full from this rain
            dryableLakesHeap.add([nextRain[i], lakeId]); // Add to heap, prioritized by its next rain day
        } else { // Dry day
            if (dryableLakesHeap.isEmpty()) {
                // No lakes need drying, ans[i] remains 1 (default)
            } else {
                // Pick the lake that will rain again soonest to dry
                const [nextRainForLakeToDry, lakeToDry] = dryableLakesHeap.extractMin();
                ans[i] = lakeToDry; // Dry this lake
                fullLakes.delete(lakeToDry); // Mark it as no longer full
            }
        }
    }

    return ans;
};