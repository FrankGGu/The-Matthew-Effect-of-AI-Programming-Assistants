class MedianFinder {
    constructor() {
        this.minHeap = [];
        this.maxHeap = [];
    }

    addNum(num) {
        if (this.maxHeap.length === 0 || num <= this.maxHeap[0]) {
            this.maxHeap.push(num);
            this.heapifyMax(this.maxHeap, this.maxHeap.length - 1);
        } else {
            this.minHeap.push(num);
            this.heapifyMin(this.minHeap, this.minHeap.length - 1);
        }

        if (this.maxHeap.length > this.minHeap.length + 1) {
            this.minHeap.push(this.maxHeap[0]);
            this.heapifyMin(this.minHeap, this.minHeap.length - 1);
            this.maxHeap[0] = this.maxHeap.pop();
            this.heapifyMax(this.maxHeap, 0);
        } else if (this.minHeap.length > this.maxHeap.length) {
            this.maxHeap.push(this.minHeap[0]);
            this.heapifyMax(this.maxHeap, this.maxHeap.length - 1);
            this.minHeap[0] = this.minHeap.pop();
            this.heapifyMin(this.minHeap, 0);
        }
    }

    findMedian() {
        if (this.maxHeap.length === this.minHeap.length) {
            return (this.maxHeap[0] + this.minHeap[0]) / 2;
        } else {
            return this.maxHeap[0];
        }
    }

    heapifyMax(arr, i) {
        let parent = i;
        while (parent > 0) {
            let parentIndex = Math.floor((parent - 1) / 2);
            if (arr[parent] > arr[parentIndex]) {
                [arr[parent], arr[parentIndex]] = [arr[parentIndex], arr[parent]];
                parent = parentIndex;
            } else {
                break;
            }
        }

        let n = arr.length;
        i = 0;
        while (true) {
            let largest = i;
            let left = 2 * i + 1;
            let right = 2 * i + 2;

            if (left < n && arr[left] > arr[largest]) {
                largest = left;
            }

            if (right < n && arr[right] > arr[largest]) {
                largest = right;
            }

            if (largest !== i) {
                [arr[i], arr[largest]] = [arr[largest], arr[i]];
                i = largest;
            } else {
                break;
            }
        }
    }

    heapifyMin(arr, i) {
        let parent = i;
        while (parent > 0) {
            let parentIndex = Math.floor((parent - 1) / 2);
            if (arr[parent] < arr[parentIndex]) {
                [arr[parent], arr[parentIndex]] = [arr[parentIndex], arr[parent]];
                parent = parentIndex;
            } else {
                break;
            }
        }

        let n = arr.length;
        i = 0;
        while (true) {
            let smallest = i;
            let left = 2 * i + 1;
            let right = 2 * i + 2;

            if (left < n && arr[left] < arr[smallest]) {
                smallest = left;
            }

            if (right < n && arr[right] < arr[smallest]) {
                smallest = right;
            }

            if (smallest !== i) {
                [arr[i], arr[smallest]] = [arr[smallest], arr[i]];
                i = smallest;
            } else {
                break;
            }
        }
    }
}