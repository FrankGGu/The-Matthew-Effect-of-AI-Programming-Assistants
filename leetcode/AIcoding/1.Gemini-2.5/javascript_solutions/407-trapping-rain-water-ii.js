class MinHeap {
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

    swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    peek() {
        if (this.heap.length === 0) return null;
        return this.heap[0];
    }

    insert(item) {
        this.heap.push(item);
        this.heapifyUp();
    }

    extractMin() {
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

    isEmpty() {
        return this.heap.length === 0;
    }
}

var trapRainWater = function(heights) {
    const m = heights.length;
    if (m === 0) return 0;
    const n = heights[0].length;
    if (n === 0) return 0;

    if (m < 3 || n < 3) return 0;

    const visited = Array(m).fill(0).map(() => Array(n).fill(false));
    const minHeap = new MinHeap();

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (r === 0 || r === m - 1 || c === 0 || c === n - 1) {
                minHeap.insert([heights[r][c], r, c]);
                visited[r][c] = true;
            }
        }
    }

    let totalWater = 0;
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (!minHeap.isEmpty()) {
        const [currentHeight, r, c] = minHeap.extractMin();

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc]) {
                visited[nr][nc] = true;

                totalWater += Math.max(0, currentHeight - heights[nr][nc]);

                minHeap.insert([Math.max(currentHeight, heights[nr][nc]), nr, nc]);
            }
        }
    }

    return totalWater;
};