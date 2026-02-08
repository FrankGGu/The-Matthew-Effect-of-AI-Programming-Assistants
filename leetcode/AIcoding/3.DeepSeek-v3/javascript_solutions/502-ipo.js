var findMaximizedCapital = function(k, w, profits, capital) {
    const n = profits.length;
    let projects = [];
    for (let i = 0; i < n; i++) {
        projects.push([capital[i], profits[i]]);
    }
    projects.sort((a, b) => a[0] - b[0]);

    let maxHeap = new MaxHeap();
    let i = 0;
    while (k > 0) {
        while (i < n && projects[i][0] <= w) {
            maxHeap.insert(projects[i][1]);
            i++;
        }
        if (maxHeap.size() === 0) {
            break;
        }
        w += maxHeap.extractMax();
        k--;
    }
    return w;
};

class MaxHeap {
    constructor() {
        this.heap = [];
    }

    size() {
        return this.heap.length;
    }

    insert(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    extractMax() {
        if (this.size() === 0) return null;
        const max = this.heap[0];
        const end = this.heap.pop();
        if (this.size() > 0) {
            this.heap[0] = end;
            this.bubbleDown(0);
        }
        return max;
    }

    bubbleUp(idx) {
        const element = this.heap[idx];
        while (idx > 0) {
            const parentIdx = Math.floor((idx - 1) / 2);
            const parent = this.heap[parentIdx];
            if (element <= parent) break;
            this.heap[idx] = parent;
            this.heap[parentIdx] = element;
            idx = parentIdx;
        }
    }

    bubbleDown(idx) {
        const length = this.size();
        const element = this.heap[idx];
        while (true) {
            let leftChildIdx = 2 * idx + 1;
            let rightChildIdx = 2 * idx + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIdx < length) {
                leftChild = this.heap[leftChildIdx];
                if (leftChild > element) {
                    swap = leftChildIdx;
                }
            }
            if (rightChildIdx < length) {
                rightChild = this.heap[rightChildIdx];
                if (
                    (swap === null && rightChild > element) ||
                    (swap !== null && rightChild > leftChild)
                ) {
                    swap = rightChildIdx;
                }
            }
            if (swap === null) break;
            this.heap[idx] = this.heap[swap];
            this.heap[swap] = element;
            idx = swap;
        }
    }
}