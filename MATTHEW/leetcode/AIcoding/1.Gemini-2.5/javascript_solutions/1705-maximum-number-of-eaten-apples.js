var eatenApples = function(apples, days) {
    class MinPriorityQueue {
        constructor() {
            this.heap = [];
        }

        getParentIndex(i) { return Math.floor((i - 1) / 2); }
        getLeftChildIndex(i) { return 2 * i + 1; }
        getRightChildIndex(i) { return 2 * i + 2; }

        hasParent(i) { return this.getParentIndex(i) >= 0; }
        hasLeftChild(i) { return this.getLeftChildIndex(i) < this.heap.length; }
        hasRightChild(i) { return this.getRightChildIndex(i) < this.heap.length; }

        getParent(i) { return this.heap[this.getParentIndex(i)]; }
        getLeftChild(i) { return this.heap[this.getLeftChildIndex(i)]; }
        getRightChild(i) { return this.heap[this.getRightChildIndex(i)]; }

        swap(i, j) {
            [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
        }

        peek() {
            if (this.heap.length === 0) return null;
            return this.heap[0];
        }

        isEmpty() {
            return this.heap.length === 0;
        }

        enqueue(item) { // item is [rottingDay, count]
            this.heap.push(item);
            this.heapifyUp();
        }

        dequeue() {
            if (this.heap.length === 0) return null;
            if (this.heap.length === 1) return this.heap.pop();

            const item = this.heap[0];
            this.heap[0] = this.heap.pop();
            this.heapifyDown();
            return item;
        }

        heapifyUp() {
            let index = this.heap.length - 1;
            while (this.hasParent(index) && this.getParent(index)[0] > this.heap[index][0]) {
                this.swap(this.getParentIndex(index), index);
                index = this.getParentIndex(index);
            }
        }

        heapifyDown() {
            let index = 0;
            while (this.hasLeftChild(index)) {
                let smallerChildIndex = this.getLeftChildIndex(index);
                if (this.hasRightChild(index) && this.getRightChild(index)[0] < this.getLeftChild(index)[0]) {
                    smallerChildIndex = this.getRightChildIndex(index);
                }

                if (this.heap[index][0] < this.heap[smallerChildIndex][0]) {
                    break;
                } else {
                    this.swap(index, smallerChildIndex);
                }
                index = smallerChildIndex;
            }
        }
    }

    let eatenApplesCount = 0;
    const n = apples.length;
    const minHeap = new MinPriorityQueue();
    let day = 0;

    while (day < n || !minHeap.isEmpty()) {
        if (day < n && apples[day] > 0) {
            const rottingDay = day + days[day];
            minHeap.enqueue([rottingDay, apples[day]]);
        }

        while (!minHeap.isEmpty() && minHeap.peek()[0] <= day) {
            minHeap.dequeue();
        }

        if (!minHeap.isEmpty()) {
            let [rottingDay, count] = minHeap.dequeue();
            eatenApplesCount++;
            count--;
            if (count > 0) {
                minHeap.enqueue([rottingDay, count]);
            }
        }
        day++;
    }

    return eatenApplesCount;
};