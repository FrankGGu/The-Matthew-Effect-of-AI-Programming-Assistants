class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var mergeKLists = function(lists) {
    const minHeap = new MinHeap();

    for (const list of lists) {
        if (list) {
            minHeap.insert(list);
        }
    }

    const dummy = new ListNode(0);
    let current = dummy;

    while (minHeap.size > 0) {
        const smallestNode = minHeap.extractMin();
        current.next = smallestNode;
        current = current.next;

        if (smallestNode.next) {
            minHeap.insert(smallestNode.next);
        }
    }

    return dummy.next;
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    insert(node) {
        this.heap.push(node);
        this.bubbleUp();
    }

    extractMin() {
        if (this.heap.length === 0) return null;
        const minNode = this.heap[0];
        const lastNode = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = lastNode;
            this.bubbleDown();
        }
        return minNode;
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[index].val >= this.heap[parentIndex].val) break;
            [this.heap[index], this.heap[parentIndex]] = [this.heap[parentIndex], this.heap[index]];
            index = parentIndex;
        }
    }

    bubbleDown() {
        let index = 0;
        const length = this.heap.length;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex < length && this.heap[leftChildIndex].val < this.heap[smallestIndex].val) {
                smallestIndex = leftChildIndex;
            }
            if (rightChildIndex < length && this.heap[rightChildIndex].val < this.heap[smallestIndex].val) {
                smallestIndex = rightChildIndex;
            }
            if (smallestIndex === index) break;

            [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
            index = smallestIndex;
        }
    }

    get size() {
        return this.heap.length;
    }
}