var findMaximizedCapital = function(k, w, profits, capital) {
    class MaxHeap {
        constructor() {
            this.heap = [];
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

        hasParent(i) {
            return this.getParentIndex(i) >= 0;
        }

        hasLeftChild(i) {
            return this.getLeftChildIndex(i) < this.heap.length;
        }

        hasRightChild(i) {
            return this.getRightChildIndex(i) < this.heap.length;
        }

        getParent(i) {
            return this.heap[this.getParentIndex(i)];
        }

        getLeftChild(i) {
            return this.heap[this.getLeftChildIndex(i)];
        }

        getRightChild(i) {
            return this.heap[this.getRightChildIndex(i)];
        }

        swap(i1, i2) {
            [this.heap[i1], this.heap[i2]] = [this.heap[i2], this.heap[i1]];
        }

        peek() {
            if (this.heap.length === 0) return null;
            return this.heap[0];
        }

        insert(item) {
            this.heap.push(item);
            this.heapifyUp();
        }

        extractMax() {
            if (this.heap.length === 0) return null;
            if (this.heap.length === 1) return this.heap.pop();

            const item = this.heap[0];
            this.heap[0] = this.heap.pop();
            this.heapifyDown();
            return item;
        }

        heapifyUp() {
            let index = this.heap.length - 1;
            while (this.hasParent(index) && this.getParent(index) < this.heap[index]) {
                this.swap(this.getParentIndex(index), index);
                index = this.getParentIndex(index);
            }
        }

        heapifyDown() {
            let index = 0;
            while (this.hasLeftChild(index)) {
                let largerChildIndex = this.getLeftChildIndex(index);
                if (this.hasRightChild(index) && this.getRightChild(index) > this.getLeftChild(index)) {
                    largerChildIndex = this.getRightChildIndex(index);
                }

                if (this.heap[index] > this.heap[largerChildIndex]) {
                    break;
                } else {
                    this.swap(index, largerChildIndex);
                    index = largerChildIndex;
                }
            }
        }

        isEmpty() {
            return this.heap.length === 0;
        }
    }

    const n = profits.length;
    const projects = [];
    for (let i = 0; i < n; i++) {
        projects.push([capital[i], profits[i]]);
    }

    projects.sort((a, b) => a[0] - b[0]);

    const maxHeap = new MaxHeap();
    let projectIndex = 0;

    for (let i = 0; i < k; i++) {
        while (projectIndex < n && projects[projectIndex][0] <= w) {
            maxHeap.insert(projects[projectIndex][1]);
            projectIndex++;
        }

        if (maxHeap.isEmpty()) {
            break;
        }

        w += maxHeap.extractMax();
    }

    return w;
};