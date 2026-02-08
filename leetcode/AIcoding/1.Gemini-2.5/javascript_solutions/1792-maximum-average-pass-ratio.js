class PriorityQueue {
    constructor(comparator = (a, b) => a - b) {
        this.heap = [];
        this.comparator = comparator;
    }

    size() {
        return this.heap.length;
    }

    peek() {
        return this.heap[0];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.size() === 0) return undefined;
        const popped = this.heap[0];
        const last = this.heap.pop();
        if (this.size() > 0) {
            this.heap[0] = last;
            this._bubbleDown(0);
        }
        return popped;
    }

    _bubbleUp(idx) {
        while (idx > 0) {
            const parentIdx = Math.floor((idx - 1) / 2);
            if (this.comparator(this.heap[idx], this.heap[parentIdx]) > 0) {
                [this.heap[idx], this.heap[parentIdx]] = [this.heap[parentIdx], this.heap[idx]];
                idx = parentIdx;
            } else {
                break;
            }
        }
    }

    _bubbleDown(idx) {
        const lastIdx = this.heap.length - 1;
        while (true) {
            let leftChildIdx = 2 * idx + 1;
            let rightChildIdx = 2 * idx + 2;
            let largestIdx = idx;

            if (leftChildIdx <= lastIdx && this.comparator(this.heap[leftChildIdx], this.heap[largestIdx]) > 0) {
                largestIdx = leftChildIdx;
            }

            if (rightChildIdx <= lastIdx && this.comparator(this.heap[rightChildIdx], this.heap[largestIdx]) > 0) {
                largestIdx = rightChildIdx;
            }

            if (largestIdx !== idx) {
                [this.heap[idx], this.heap[largestIdx]] = [this.heap[largestIdx], this.heap[idx]];
                idx = largestIdx;
            } else {
                break;
            }
        }
    }
}

function maxAverageRatio(classes, extraStudents) {
    // Max-heap: comparator returns positive if a has higher priority than b.
    // We prioritize classes that give a larger increase in ratio.
    // Elements in heap: [increase_value, current_pass, current_total]
    const pq = new PriorityQueue((a, b) => a[0] - b[0]);

    const calculateIncrease = (p, t) => {
        return (p + 1) / (t + 1) - p / t;
    };

    for (let i = 0; i < classes.length; i++) {
        let p = classes[i][0];
        let t = classes[i][1];
        let increase = calculateIncrease(p, t);
        pq.push([increase, p, t]);
    }

    while (extraStudents > 0) {
        let [currentIncrease, p, t] = pq.pop();
        p++;
        t++;
        extraStudents--;
        let newIncrease = calculateIncrease(p, t);
        pq.push([newIncrease, p, t]);
    }

    let totalRatioSum = 0;
    while (pq.size() > 0) {
        let [_, p, t] = pq.pop();
        totalRatioSum += p / t;
    }

    return totalRatioSum / classes.length;
}