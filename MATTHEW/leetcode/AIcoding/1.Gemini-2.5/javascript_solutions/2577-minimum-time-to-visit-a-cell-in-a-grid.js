class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(node) {
        this.heap.push(node);
        this.bubbleUp();
    }

    pop() {
        if (this.isEmpty()) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.bubbleDown();
        return root;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex][0] <= this.heap[index][0]) {
                break;
            }
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown() {
        let index = 0;
        const lastIndex = this.heap.length - 1;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex][0] < this.heap[smallestIndex][0]) {
                smallestIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex][0] < this.heap[smallestIndex][0]) {
                smallestIndex = rightChildIndex;
            }

            if (smallestIndex === index) {
                break;
            }

            [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
            index = smallestIndex;
        }
    }
}

var minimumTime = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    if (grid[0][0] > 0) {
        return -1;
    }

    if (m === 1 && n === 1) {
        return 0;
    }

    if (m > 1 && n > 1) {
        if (grid[0][1] > 1 && grid[1][0] > 1) {
            return -1;
        }
    }

    const dist = Array(m).fill(0).map(() => Array(n).fill(Infinity));
    const pq = new MinHeap();

    dist[0][0] = 0;
    pq.push([0, 0, 0]); // [time, row, col]

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    while (!pq.isEmpty()) {
        const [currentTime, r, c] = pq.pop();

        if (currentTime > dist[r][c]) {
            continue;
        }

        if (r === m - 1 && c === n - 1) {
            return currentTime;
        }

        for (let i = 0; i < 4; i++) {
            const nr = r + dr[i];
            const nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                const timeArriveAtNeighborBorder = currentTime + 1;
                const neighborValue = grid[nr][nc];

                let timeToEnterNeighbor;
                if (timeArriveAtNeighborBorder >= neighborValue) {
                    timeToEnterNeighbor = timeArriveAtNeighborBorder;
                } else {
                    const waitDuration = neighborValue - timeArriveAtNeighborBorder;
                    if (waitDuration % 2 === 0) {
                        timeToEnterNeighbor = neighborValue;
                    } else {
                        timeToEnterNeighbor = neighborValue + 1;
                    }
                }

                if (timeToEnterNeighbor < dist[nr][nc]) {
                    dist[nr][nc] = timeToEnterNeighbor;
                    pq.push([timeToEnterNeighbor, nr, nc]);
                }
            }
        }
    }

    return -1;
};