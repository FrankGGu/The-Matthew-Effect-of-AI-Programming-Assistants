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

    _getParent(i) { return this.heap[this._parent(i)]; }
    _getLeftChild(i) { return this.heap[this._leftChild(i)]; }
    _getRightChild(i) { return this.heap[this._rightChild(i)]; }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    peek() {
        if (this.heap.length === 0) return undefined;
        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }

    enqueue(item) {
        this.heap.push(item);
        this._heapifyUp();
    }

    dequeue() {
        if (this.heap.length === 0) return undefined;
        if (this.heap.length === 1) return this.heap.pop();

        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown();
        return item;
    }

    _heapifyUp() {
        let index = this.heap.length - 1;
        while (this._hasParent(index) && this.comparator(this._getParent(index), this.heap[index]) > 0) {
            this._swap(index, this._parent(index));
            index = this._parent(index);
        }
    }

    _heapifyDown() {
        let index = 0;
        while (this._hasLeftChild(index)) {
            let smallerChildIndex = this._leftChild(index);
            if (this._hasRightChild(index) && this.comparator(this._getRightChild(index), this._getLeftChild(index)) < 0) {
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

class SegmentTree {
    constructor(k) {
        this.k = k;
        this.tree = new Array(4 * k).fill(0);
        this.build(1, 0, k - 1);
    }

    build(node, start, end) {
        if (start === end) {
            this.tree[node] = 1;
            return;
        }
        const mid = Math.floor((start + end) / 2);
        this.build(2 * node, start, mid);
        this.build(2 * node + 1, mid + 1, end);
        this.tree[node] = this.tree[2 * node] + this.tree[2 * node + 1];
    }

    update(node, start, end, idx, val) {
        if (start === end) {
            this.tree[node] = val;
            return;
        }
        const mid = Math.floor((start + end) / 2);
        if (idx <= mid) {
            this.update(2 * node, start, mid, idx, val);
        } else {
            this.update(2 * node + 1, mid + 1, end, idx, val);
        }
        this.tree[node] = this.tree[2 * node] + this.tree[2 * node + 1];
    }

    findFirstAvailable(node, start, end, targetL, targetR) {
        if (this.tree[node] === 0 || start > targetR || end < targetL) {
            return -1;
        }
        if (start === end) {
            return start;
        }

        const mid = Math.floor((start + end) / 2);
        let res = -1;

        if (targetL <= mid) {
            res = this.findFirstAvailable(2 * node, start, mid, targetL, targetR);
        }

        if (res !== -1) {
            return res;
        }

        if (targetR > mid) {
            res = this.findFirstAvailable(2 * node + 1, mid + 1, end, targetL, targetR);
        }
        return res;
    }
}

function findServersThatHandledMostRequests(k, requests) {
    const serverFinishTime = new Array(k).fill(0);
    const requestCount = new Array(k).fill(0);

    const availableServersST = new SegmentTree(k);
    const busyServersPQ = new MinPriorityQueue(); // Stores [finishTime, serverId]

    for (let i = 0; i < requests.length; i++) {
        const [arrival, load] = requests[i];

        while (busyServersPQ.size() > 0 && busyServersPQ.peek()[0] <= arrival) {
            const [finish, serverId] = busyServersPQ.dequeue();
            availableServersST.update(1, 0, k - 1, serverId, 1);
        }

        let foundServerId = -1;
        const startSearchIndex = i % k;

        let res = availableServersST.findFirstAvailable(1, 0, k - 1, startSearchIndex, k - 1);
        if (res !== -1) {
            foundServerId = res;
        } else {
            res = availableServersST.findFirstAvailable(1, 0, k - 1, 0, startSearchIndex - 1);
            if (res !== -1) {
                foundServerId = res;
            }
        }

        if (foundServerId !== -1) {
            serverFinishTime[foundServerId] = arrival + load;
            requestCount[foundServerId]++;
            availableServersST.update(1, 0, k - 1, foundServerId, 0);
            busyServersPQ.enqueue([arrival + load, foundServerId]);
        }
    }

    let maxRequests = 0;
    for (let i = 0; i < k; i++) {
        if (requestCount[i] > maxRequests) {
            maxRequests = requestCount[i];
        }
    }

    const result = [];
    for (let i = 0; i < k; i++) {
        if (requestCount[i] === maxRequests) {
            result.push(i);
        }
    }

    return result;
}