class MinPriorityQueue {
    constructor(comparator = (a, b) => a[0] - b[0]) {
        this.heap = [];
        this.comparator = comparator;
    }

    _parent(i) { return Math.floor((i - 1) / 2); }
    _leftChild(i) { return 2 * i + 1; }
    _rightChild(i) { return 2 * i + 2; }
    _hasParent(i) { return this._parent(i) >= 0; }
    _hasLeftChild(i) { return this._leftChild(i) < this.heap.length; }
    _hasRightChild(i) { return this._rightChild(i) < this.heap.length; }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    isEmpty() { return this.heap.length === 0; }
    peek() { return this.heap[0]; }
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
        while (this._hasParent(index) && this.comparator(this.heap[this._parent(index)], this.heap[index]) > 0) {
            this._swap(index, this._parent(index));
            index = this._parent(index);
        }
    }

    _heapifyDown() {
        let index = 0;
        while (this._hasLeftChild(index)) {
            let smallerChildIndex = this._leftChild(index);
            if (this._hasRightChild(index) && this.comparator(this.heap[this._rightChild(index)], this.heap[smallerChildIndex]) < 0) {
                smallerChildIndex = this._rightChild(index);
            }

            if (this.comparator(this.heap[index], this.heap[smallerChildIndex]) < 0) {
                break;
            } else {
                this._swap(index, smallerChildIndex);
            }
            index = smallerChildIndex;
        }
    }
}

function processTasks(servers, tasks) {
    const ans = new Array(tasks.length);

    const availableServers = new MinPriorityQueue((a, b) => a[0] - b[0] || a[1] - b[1]);
    const busyServers = new MinPriorityQueue((a, b) => a[0] - b[0] || a[1] - b[1] || a[2] - b[2]);

    for (let i = 0; i < servers.length; i++) {
        availableServers.enqueue([servers[i], i]);
    }

    let time = 0;

    for (let i = 0; i < tasks.length; i++) {
        const taskArrival = i;
        const taskDuration = tasks[i];

        time = Math.max(time, taskArrival);

        while (!busyServers.isEmpty() && busyServers.peek()[0] <= time) {
            const [finishT, w, idx] = busyServers.dequeue();
            availableServers.enqueue([w, idx]);
        }

        if (availableServers.isEmpty()) {
            time = busyServers.peek()[0];
            while (!busyServers.isEmpty() && busyServers.peek()[0] <= time) {
                const [finishT, w, idx] = busyServers.dequeue();
                availableServers.enqueue([w, idx]);
            }
        }

        const [serverWeight, serverIndex] = availableServers.dequeue();
        ans[i] = serverIndex;
        busyServers.enqueue([time + taskDuration, serverWeight, serverIndex]);
    }

    return ans;
}