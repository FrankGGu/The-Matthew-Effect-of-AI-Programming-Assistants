class PriorityQueue {
    constructor(compareFn) {
        this.heap = [];
        this.compare = compareFn;
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

    push(item) {
        this.heap.push(item);
        this.heapifyUp();
    }

    pop() {
        if (this.heap.length === 0) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.heapifyDown();
        return item;
    }

    heapifyUp() {
        let index = this.heap.length - 1;
        while (this.hasParent(index) && this.compare(this.heap[index], this.getParent(index)) < 0) {
            this.swap(index, this.getParentIndex(index));
            index = this.getParentIndex(index);
        }
    }

    heapifyDown() {
        let index = 0;
        while (this.hasLeftChild(index)) {
            let preferredChildIndex = this.getLeftChildIndex(index);
            if (this.hasRightChild(index) && this.compare(this.getRightChild(index), this.getLeftChild(index)) < 0) {
                preferredChildIndex = this.getRightChildIndex(index);
            }

            if (this.compare(this.heap[index], this.heap[preferredChildIndex]) < 0) {
                break;
            } else {
                this.swap(index, preferredChildIndex);
            }
            index = preferredChildIndex;
        }
    }

    get size() {
        return this.heap.length;
    }
}

var getNumberOfBacklogOrders = function(orders) {
    const MOD = 10**9 + 7;

    // Min-heap for sell orders: [price, amount]. Smallest price at top.
    const sellOrders = new PriorityQueue((a, b) => a[0] - b[0]);
    // Max-heap for buy orders: [price, amount]. Largest price at top.
    const buyOrders = new PriorityQueue((a, b) => b[0] - a[0]);

    for (const [price, amount, type] of orders) {
        if (type === 0) { // Buy order
            let currentBuyAmount = amount;
            while (currentBuyAmount > 0 && sellOrders.size > 0 && sellOrders.peek()[0] <= price) {
                const [sPrice, sAmount] = sellOrders.pop();
                if (currentBuyAmount >= sAmount) {
                    currentBuyAmount -= sAmount;
                } else {
                    sellOrders.push([sPrice, sAmount - currentBuyAmount]);
                    currentBuyAmount = 0;
                }
            }
            if (currentBuyAmount > 0) {
                buyOrders.push([price, currentBuyAmount]);
            }
        } else { // Sell order
            let currentSellAmount = amount;
            while (currentSellAmount > 0 && buyOrders.size > 0 && buyOrders.peek()[0] >= price) {
                const [bPrice, bAmount] = buyOrders.pop();
                if (currentSellAmount >= bAmount) {
                    currentSellAmount -= bAmount;
                } else {
                    buyOrders.push([bPrice, bAmount - currentSellAmount]);
                    currentSellAmount = 0;
                }
            }
            if (currentSellAmount > 0) {
                sellOrders.push([price, currentSellAmount]);
            }
        }
    }

    let totalBacklog = 0;
    while (buyOrders.size > 0) {
        totalBacklog = (totalBacklog + buyOrders.pop()[1]) % MOD;
    }
    while (sellOrders.size > 0) {
        totalBacklog = (totalBacklog + sellOrders.pop()[1]) % MOD;
    }

    return totalBacklog;
};