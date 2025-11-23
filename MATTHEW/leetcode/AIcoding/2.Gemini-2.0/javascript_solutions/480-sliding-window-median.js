class Heap {
    constructor(type = 'min') {
        this.heap = [];
        this.type = type;
    }

    compare(a, b) {
        if (this.type === 'min') {
            return a < b;
        } else {
            return a > b;
        }
    }

    swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    getParentIndex(i) {
        return Math.floor((i - 1) / 2);
    }

    getLeftChildIndex(i) {
        return 2 * i + 1;
    }

    getRightChildIndex(i) {
        return 2 * i + 2;
    }

    peek() {
        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    insert(val) {
        this.heap.push(val);
        this.heapifyUp(this.heap.length - 1);
    }

    heapifyUp(index) {
        let parentIndex = this.getParentIndex(index);
        while (index > 0 && !this.compare(this.heap[parentIndex], this.heap[index])) {
            this.swap(index, parentIndex);
            index = parentIndex;
            parentIndex = this.getParentIndex(index);
        }
    }

    remove() {
        if (this.isEmpty()) {
            return null;
        }

        if (this.heap.length === 1) {
            return this.heap.pop();
        }

        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.heapifyDown(0);
        return root;
    }

    heapifyDown(index) {
        let smallest = index;
        const leftIndex = this.getLeftChildIndex(index);
        const rightIndex = this.getRightChildIndex(index);

        if (leftIndex < this.heap.length && !this.compare(this.heap[smallest], this.heap[leftIndex])) {
            smallest = leftIndex;
        }

        if (rightIndex < this.heap.length && !this.compare(this.heap[smallest], this.heap[rightIndex])) {
            smallest = rightIndex;
        }

        if (smallest !== index) {
            this.swap(index, smallest);
            this.heapifyDown(smallest);
        }
    }
}

var medianSlidingWindow = function(nums, k) {
    const minHeap = new Heap('min');
    const maxHeap = new Heap('max');
    const result = [];

    const balanceHeaps = () => {
        if (maxHeap.size() > minHeap.size() + 1) {
            minHeap.insert(maxHeap.remove());
        } else if (minHeap.size() > maxHeap.size()) {
            maxHeap.insert(minHeap.remove());
        }
    };

    for (let i = 0; i < nums.length; i++) {
        if (maxHeap.isEmpty() || nums[i] <= maxHeap.peek()) {
            maxHeap.insert(nums[i]);
        } else {
            minHeap.insert(nums[i]);
        }

        balanceHeaps();

        if (i >= k - 1) {
            if (k % 2 === 0) {
                result.push((maxHeap.peek() + minHeap.peek()) / 2);
            } else {
                result.push(maxHeap.peek());
            }

            const toRemove = nums[i - k + 1];
            if (toRemove <= maxHeap.peek()) {
                const index = maxHeap.heap.indexOf(toRemove);
                maxHeap.heap.splice(index, 1);
                maxHeap.heapifyDown(0);
                for (let j = Math.floor((maxHeap.heap.length - 1) / 2); j >= 0; j--) {
                    maxHeap.heapifyDown(j);
                }

            } else {
                const index = minHeap.heap.indexOf(toRemove);
                minHeap.heap.splice(index, 1);
                minHeap.heapifyDown(0);
                for (let j = Math.floor((minHeap.heap.length - 1) / 2); j >= 0; j--) {
                    minHeap.heapifyDown(j);
                }
            }

             while (maxHeap.size() > minHeap.size() + 1) {
                minHeap.insert(maxHeap.remove());
            } else if (minHeap.size() > maxHeap.size()) {
                maxHeap.insert(minHeap.remove());
            }
        }
    }

    return result;
};