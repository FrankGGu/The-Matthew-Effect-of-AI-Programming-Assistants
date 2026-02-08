var kthSmallest = function(mat, k) {
    const m = mat.length, n = mat[0].length;
    const minHeap = new MinPriorityQueue({ priority: (a, b) => a[0] - b[0] });
    const initialSum = mat[0][0];
    minHeap.enqueue([initialSum, 0, 0]);
    const visited = new Set();
    visited.add('0,0');

    while (k > 0) {
        const [sum, x, y] = minHeap.dequeue().element;
        if (--k === 0) return sum;

        if (x + 1 < m) {
            const newSum = sum - mat[x][y] + mat[x + 1][y];
            const position = (x + 1) + ',' + y;
            if (!visited.has(position)) {
                visited.add(position);
                minHeap.enqueue([newSum, x + 1, y]);
            }
        }
        if (y + 1 < n) {
            const newSum = sum - mat[x][y] + mat[x][y + 1];
            const position = x + ',' + (y + 1);
            if (!visited.has(position)) {
                visited.add(position);
                minHeap.enqueue([newSum, x, y + 1]);
            }
        }
    }
};