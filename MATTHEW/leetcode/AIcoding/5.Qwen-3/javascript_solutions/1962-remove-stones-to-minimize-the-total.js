function minStoneSum(piles, k) {
    const heap = new Heap((a, b) => a > b);
    for (const pile of piles) {
        heap.push(pile);
    }

    for (let i = 0; i < k; i++) {
        const maxPile = heap.pop();
        const remove = Math.floor(maxPile / 2);
        heap.push(maxPile - remove);
    }

    let total = 0;
    while (!heap.isEmpty()) {
        total += heap.pop();
    }

    return total;
}

class Heap {
    constructor(comparator = (a, b) => a > b) {
        this.comparator = comparator;
        this.heap = [];
    }

    push(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.heap.length === 0) return undefined;
        const value = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.bubbleDown(0);
        }
        return value;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.comparator(this.heap[parentIndex], this.heap[index])) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const value = this.heap[index];
        while (true) {
            let leftChildIndex = index * 2 + 1;
            let rightChildIndex = index * 2 + 2;
            let swapIndex = null;

            if (leftChildIndex < length && this.comparator(this.heap[leftChildIndex], value)) {
                swapIndex = leftChildIndex;
            }

            if (rightChildIndex < length && this.comparator(this.heap[rightChildIndex], value)) {
                if (swapIndex === null || this.comparator(this.heap[rightChildIndex], this.heap[swapIndex])) {
                    swapIndex = rightChildIndex;
                }
            }

            if (swapIndex === null) break;

            [this.heap[index], this.heap[swapIndex]] = [this.heap[swapIndex], this.heap[index]];
            index = swapIndex;
        }
    }
}