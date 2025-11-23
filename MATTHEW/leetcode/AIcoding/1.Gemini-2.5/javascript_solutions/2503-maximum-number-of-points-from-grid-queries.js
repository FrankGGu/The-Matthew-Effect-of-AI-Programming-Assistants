class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.bubbleDown(0);
        return min;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp(index) {
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex][0] > this.heap[index][0]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    bubbleDown(index) {
        let leftChildIndex = 2 * index + 1;
        let rightChildIndex = 2 * index + 2;
        let smallestIndex = index;

        if (leftChildIndex < this.heap.length && this.heap[leftChildIndex][0] < this.heap[smallestIndex][0]) {
            smallestIndex = leftChildIndex;
        }

        if (rightChildIndex < this.heap.length && this.heap[rightChildIndex][0] < this.heap[smallestIndex][0]) {
            smallestIndex = rightChildIndex;
        }

        if (smallestIndex !== index) {
            [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
            this.bubbleDown(smallestIndex);
        }
    }
}

var maxPoints = function(grid, queries) {
    const m = grid.length;
    const n = grid[0].length;
    const numQueries = queries.length;

    const sortedQueries = queries.map((q, i) => ({ value: q, originalIndex: i }));
    sortedQueries.sort((a, b) => a.value - b.value);

    const results = new Array(numQueries);

    const pq = new MinHeap();
    pq.push([grid[0][0], 0, 0]);

    const visited = Array(m).fill(0).map(() => Array(n).fill(false));
    visited[0][0] = true;

    let currentReachableCells = 0;
    let queryIdx = 0;

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queryIdx < numQueries) {
        const currentQuery = sortedQueries[queryIdx];
        const currentQueryValue = currentQuery.value;
        const originalQueryIndex = currentQuery.originalIndex;

        while (!pq.isEmpty() && pq.peek()[0] < currentQueryValue) {
            const [cellValue, r, c] = pq.pop();
            currentReachableCells++;

            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc]) {
                    visited[nr][nc] = true;
                    pq.push([grid[nr][nc], nr, nc]);
                }
            }
        }

        results[originalQueryIndex] = currentReachableCells;
        queryIdx++;
    }

    return results;
};