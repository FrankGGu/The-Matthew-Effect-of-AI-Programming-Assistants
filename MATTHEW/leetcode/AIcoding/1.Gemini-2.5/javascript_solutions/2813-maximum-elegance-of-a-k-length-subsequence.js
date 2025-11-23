class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) {
            return undefined;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return min;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    size() {
        return this.heap.length;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] > this.heap[index]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _bubbleDown(index) {
        const lastIndex = this.heap.length - 1;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = rightChildIndex;
            }

            if (smallestIndex !== index) {
                [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
                index = smallestIndex;
            } else {
                break;
            }
        }
    }
}

var findMaximumElegance = function(items, k) {
    items.sort((a, b) => b[0] - a[0]);

    let currentProfitSum = 0n;
    const distinctCategories = new Set();
    const duplicateProfits = new MinHeap();

    for (let i = 0; i < k; i++) {
        const [profit, category] = items[i];
        currentProfitSum += BigInt(profit);
        if (distinctCategories.has(category)) {
            duplicateProfits.push(profit);
        }
        distinctCategories.add(category);
    }

    let maxElegance = currentProfitSum + BigInt(distinctCategories.size) * BigInt(distinctCategories.size);

    for (let i = k; i < items.length; i++) {
        const [profitNew, categoryNew] = items[i];

        if (distinctCategories.has(categoryNew) || duplicateProfits.isEmpty()) {
            continue;
        }

        const profitOld = duplicateProfits.pop();
        currentProfitSum = currentProfitSum - BigInt(profitOld) + BigInt(profitNew);
        distinctCategories.add(categoryNew);

        const currentElegance = currentProfitSum + BigInt(distinctCategories.size) * BigInt(distinctCategories.size);
        if (currentElegance > maxElegance) {
            maxElegance = currentElegance;
        }
    }

    return Number(maxElegance);
};