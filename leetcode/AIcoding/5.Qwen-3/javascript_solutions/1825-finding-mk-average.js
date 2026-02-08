var MKAverage = function (m, k) {
    this.m = m;
    this.k = k;
    this.n = 0;
    this.data = [];
    this.sorted = [];
    this.minHeap = new MinHeap();
    this.maxHeap = new MaxHeap();
    this.middle = [];
};

MKAverage.prototype.add = function (num) {
    this.data.push(num);
    this.n++;
    this.sorted.push(num);
    this.sorted.sort((a, b) => a - b);
    if (this.n > this.m) {
        this.remove(this.data[this.n - this.m - 1]);
    }
    this.addHeap(num);
    if (this.n >= this.m) {
        this.middle.push(this.getMiddle());
    }
};

MKAverage.prototype.calculate = function () {
    return this.middle.length === 0 ? -1 : this.middle[this.middle.length - 1];
};

MKAverage.prototype.addHeap = function (num) {
    if (this.minHeap.size() < this.k) {
        this.minHeap.push(num);
    } else if (this.maxHeap.size() < this.k) {
        this.maxHeap.push(num);
    } else {
        const mid = this.minHeap.peek() + this.maxHeap.peek() >> 1;
        if (num <= mid) {
            this.maxHeap.push(num);
        } else {
            this.minHeap.push(num);
        }
    }
};

MKAverage.prototype.remove = function (num) {
    if (this.minHeap.contains(num)) {
        this.minHeap.remove(num);
    } else if (this.maxHeap.contains(num)) {
        this.maxHeap.remove(num);
    } else {
        let index = this.sorted.indexOf(num);
        if (index !== -1) {
            this.sorted.splice(index, 1);
        }
    }
};

MKAverage.prototype.getMiddle = function () {
    let sum = 0;
    for (let i = this.k; i < this.m - this.k; i++) {
        sum += this.sorted[i];
    }
    return sum / (this.m - 2 * this.k);
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        const top = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.bubbleDown(0);
        }
        return top;
    }

    peek() {
        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }

    contains(val) {
        return this.heap.includes(val);
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] <= this.heap[index]) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const element = this.heap[index];
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let swapIndex = null;

            if (leftChildIndex < length && this.heap[leftChildIndex] < element) {
                swapIndex = leftChildIndex;
            }

            if (rightChildIndex < length && this.heap[rightChildIndex] < (swapIndex === null ? element : this.heap[swapIndex])) {
                swapIndex = rightChildIndex;
            }

            if (swapIndex === null) break;
            [this.heap[index], this.heap[swapIndex]] = [this.heap[swapIndex], this.heap[index]];
            index = swapIndex;
        }
    }

    remove(val) {
        const index = this.heap.indexOf(val);
        if (index === -1) return;
        const last = this.heap.pop();
        if (index !== this.heap.length) {
            this.heap[index] = last;
            this.bubbleDown(index);
        }
    }
}

class MaxHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        const top = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.bubbleDown(0);
        }
        return top;
    }

    peek() {
        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }

    contains(val) {
        return this.heap.includes(val);
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] >= this.heap[index]) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const element = this.heap[index];
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let swapIndex = null;

            if (leftChildIndex < length && this.heap[leftChildIndex] > element) {
                swapIndex = leftChildIndex;
            }

            if (rightChildIndex < length && this.heap[rightChildIndex] > (swapIndex === null ? element : this.heap[swapIndex])) {
                swapIndex = rightChildIndex;
            }

            if (swapIndex === null) break;
            [this.heap[index], this.heap[swapIndex]] = [this.heap[swapIndex], this.heap[index]];
            index = swapIndex;
        }
    }

    remove(val) {
        const index = this.heap.indexOf(val);
        if (index === -1) return;
        const last = this.heap.pop();
        if (index !== this.heap.length) {
            this.heap[index] = last;
            this.bubbleDown(index);
        }
    }
};