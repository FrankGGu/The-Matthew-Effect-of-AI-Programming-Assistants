class MaxPriorityQueue {
    constructor() {
        this.heap = [];
        // Comparator for ExamRoom problem:
        // Primary: dist (descending)
        // Secondary: pos (ascending)
        this.comparator = (a, b) => {
            if (b.dist !== a.dist) {
                return b.dist - a.dist;
            }
            return a.pos - b.pos;
        };
    }

    _parent(i) { return Math.floor((i - 1) / 2); }
    _leftChild(i) { return 2 * i + 1; }
    _rightChild(i) { return 2 * i + 2; }
    _hasParent(i) { return this._parent(i) >= 0; }
    _hasLeftChild(i) { return this._leftChild(i) < this.heap.length; }
    _hasRightChild(i) { return this._rightChild(i) < this.heap.length; }
    _getLeftChild(i) { return this.heap[this._leftChild(i)]; }
    _getRightChild(i) { return this.heap[this._rightChild(i)]; }
    _getParent(i) { return this.heap[this._parent(i)]; }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    enqueue(item) {
        this.heap.push(item);
        this._heapifyUp();
    }

    dequeue() {
        if (this.heap.length === 0) return null;
        if (this.heap.length === 1) return { element: this.heap.pop() };

        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown();
        return { element: item };
    }

    peek() {
        if (this.heap.length === 0) return null;
        return { element: this.heap[0] };
    }

    get size() {
        return this.heap.length;
    }

    _heapifyUp() {
        let index = this.heap.length - 1;
        while (this._hasParent(index) && this.comparator(this.heap[index], this._getParent(index)) > 0) {
            this._swap(index, this._parent(index));
            index = this._parent(index);
        }
    }

    _heapifyDown() {
        let index = 0;
        while (this._hasLeftChild(index)) {
            let largerChildIndex = this._leftChild(index);
            if (this._hasRightChild(index) && this.comparator(this._getRightChild(index), this._getLeftChild(index)) > 0) {
                largerChildIndex = this._rightChild(index);
            }

            if (this.comparator(this.heap[index], this.heap[largerChildIndex]) > 0) {
                break;
            } else {
                this._swap(index, largerChildIndex);
                index = largerChildIndex;
            }
        }
    }
}

class ExamRoom {
    constructor(n) {
        this.n = n;
        this.seated = new Set();
        this.next = new Map();
        this.prev = new Map();
        this.pq = new MaxPriorityQueue();

        this.next.set(-1, n);
        this.prev.set(n, -1);
        this.pq.enqueue(this._calculateGapInfo(-1, n));
    }

    _calculateGapInfo(p1, p2) {
        let dist, pos;
        if (p1 === -1 && p2 === this.n) {
            dist = this.n - 1;
            pos = 0;
        } else if (p1 === -1) {
            dist = p2;
            pos = 0;
        } else if (p2 === this.n) {
            dist = this.n - 1 - p1;
            pos = this.n - 1;
        } else {
            dist = Math.floor((p2 - p1) / 2);
            pos = p1 + dist;
        }
        return { dist, pos, p1, p2 };
    }

    seat() {
        let p;
        let p1_chosen, p2_chosen;
        while (true) {
            const bestGap = this.pq.dequeue().element;
            const { p1, p2, pos } = bestGap;

            let isValid = false;
            if (p1 === -1 && p2 === this.n) {
                isValid = this.seated.size === 0;
            } else if (p1 === -1) {
                isValid = this.seated.has(p2) && this.prev.get(p2) === -1;
            } else if (p2 === this.n) {
                isValid = this.seated.has(p1) && this.next.get(p1) === this.n;
            } else {
                isValid = this.seated.has(p1) && this.seated.has(p2) && this.next.get(p1) === p2;
            }

            if (isValid) {
                p = pos;
                p1_chosen = p1;
                p2_chosen = p2;
                break;
            }
        }

        this.seated.add(p);

        this.next.set(p1_chosen, p);
        this.prev.set(p, p1_chosen);
        this.next.set(p, p2_chosen);
        this.prev.set(p2_chosen, p);

        this.pq.enqueue(this._calculateGapInfo(p1_chosen, p));
        this.pq.enqueue(this._calculateGapInfo(p, p2_chosen));

        return p;
    }

    leave(p) {
        this.seated.delete(p);

        const p1 = this.prev.get(p);
        const p2 = this.next.get(p);

        this.next.set(p1, p2);
        this.prev.set(p2, p1);

        this.next.delete(p);
        this.prev.delete(p);

        this.pq.enqueue(this._calculateGapInfo(p1, p2));
    }
}