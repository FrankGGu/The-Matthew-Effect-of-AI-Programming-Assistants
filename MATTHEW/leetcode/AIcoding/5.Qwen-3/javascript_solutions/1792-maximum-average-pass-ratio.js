function maxAveragePassRatio(students, threshold) {
    const n = students.length;
    const heap = new MaxHeap();

    for (let i = 0; i < n; i++) {
        const [pass, total] = students[i];
        const ratio = pass / total;
        const nextRatio = (pass + 1) / (total + 1);
        const diff = nextRatio - ratio;
        heap.insert([diff, pass, total]);
    }

    for (let i = 0; i < threshold; i++) {
        const [diff, pass, total] = heap.extractMax();
        const newPass = pass + 1;
        const newTotal = total + 1;
        const newRatio = newPass / newTotal;
        const nextDiff = (newPass + 1) / (newTotal + 1) - newRatio;
        heap.insert([nextDiff, newPass, newTotal]);
    }

    let totalPassRatio = 0;
    for (let i = 0; i < n; i++) {
        const [pass, total] = students[i];
        totalPassRatio += pass / total;
    }

    return totalPassRatio / n;
}

class MaxHeap {
    constructor() {
        this.heap = [];
    }

    insert(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    extractMax() {
        const max = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.bubbleDown(0);
        }
        return max;
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex][0] >= this.heap[index][0]) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const element = this.heap[index];

        while (true) {
            let leftChildIdx = 2 * index + 1;
            let rightChildIdx = 2 * index + 2;
            let swap = null;

            if (leftChildIdx < length) {
                if (this.heap[leftChildIdx][0] > element[0]) {
                    swap = leftChildIdx;
                }
            }

            if (rightChildIdx < length) {
                if (
                    (swap === null && this.heap[rightChildIdx][0] > element[0]) ||
                    (swap !== null && this.heap[rightChildIdx][0] > this.heap[swap][0])
                ) {
                    swap = rightChildIdx;
                }
            }

            if (swap === null) break;
            [this.heap[index], this.heap[swap]] = [this.heap[swap], this.heap[index]];
            index = swap;
        }
    }
}