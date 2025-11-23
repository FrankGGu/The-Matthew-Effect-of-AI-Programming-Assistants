class MaxPriorityQueue {
    constructor() {
        this.heap = [];
    }

    _getParentIndex(i) { return Math.floor((i - 1) / 2); }
    _getLeftChildIndex(i) { return 2 * i + 1; }
    _getRightChildIndex(i) { return 2 * i + 2; }

    _hasParent(i) { return this._getParentIndex(i) >= 0; }
    _hasLeftChild(i) { return this._getLeftChildIndex(i) < this.heap.length; }
    _hasRightChild(i) { return this._getRightChildIndex(i) < this.heap.length; }

    _getParent(i) { return this.heap[this._getParentIndex(i)]; }
    _getLeftChild(i) { return this.heap[this._getLeftChildIndex(i)]; }
    _getRightChild(i) { return this.heap[this._getRightChildIndex(i)]; }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    isEmpty() { return this.heap.length === 0; }
    peek() { 
        if (this.isEmpty()) return undefined;
        return this.heap[0]; 
    }
    size() { return this.heap.length; }

    enqueue(item) {
        this.heap.push(item);
        this._heapifyUp();
    }

    dequeue() {
        if (this.isEmpty()) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown();
        return item;
    }

    _heapifyUp() {
        let index = this.heap.length - 1;
        while (this._hasParent(index) && this._getParent(index) < this.heap[index]) {
            this._swap(this._getParentIndex(index), index);
            index = this._getParentIndex(index);
        }
    }

    _heapifyDown() {
        let index = 0;
        while (this._hasLeftChild(index)) {
            let largerChildIndex = this._getLeftChildIndex(index);
            if (this._hasRightChild(index) && this._getRightChild(index) > this._getLeftChild(index)) {
                largerChildIndex = this._getRightChildIndex(index);
            }

            if (this.heap[index] < this.heap[largerChildIndex]) {
                this._swap(index, largerChildIndex);
                index = largerChildIndex;
            } else {
                break;
            }
        }
    }
}

var maxTaskAssign = function(tasks, workers, pills, strength) {
    tasks.sort((a, b) => a - b);
    workers.sort((a, b) => a - b);

    const n = tasks.length;
    const m = workers.length;

    let low = 0;
    let high = Math.min(n, m);
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans;

    function check(k) {
        if (k === 0) return true;

        let currentPills = pills;
        let workerPtr = 0; 
        const eligibleWorkers = new MaxPriorityQueue(); 

        for (let taskIdx = 0; taskIdx < k; taskIdx++) {
            const currentTask = tasks[taskIdx];

            while (workerPtr < m && workers[workerPtr] + strength >= currentTask) {
                eligibleWorkers.enqueue(workers[workerPtr]);
                workerPtr++;
            }

            if (eligibleWorkers.isEmpty()) {
                return false;
            }

            if (eligibleWorkers.peek() >= currentTask) {
                eligibleWorkers.dequeue(); 
            } else {
                if (currentPills > 0) {
                    currentPills--;
                    eligibleWorkers.dequeue(); 
                } else {
                    return false;
                }
            }
        }
        return true;
    }
};