var kthSmallest = function(mat, k) {
    let m = mat.length;
    let n = mat[0].length;
    let pq = new PriorityQueue((a, b) => b - a);
    pq.push(0);

    for (let i = 0; i < m; i++) {
        let nextPq = new PriorityQueue((a, b) => b - a);
        while (!pq.isEmpty()) {
            let sum = pq.pop();
            for (let j = 0; j < n; j++) {
                nextPq.push(sum + mat[i][j]);
                if (nextPq.size() > k) {
                    nextPq.pop();
                }
            }
        }
        pq = nextPq;
    }

    return pq.peek();

    function PriorityQueue(comparator) {
        this.comparator = comparator;
        this.queue = [];
    }

    PriorityQueue.prototype.push = function(val) {
        this.queue.push(val);
        this.queue.sort(this.comparator);
    }

    PriorityQueue.prototype.pop = function() {
        return this.queue.pop();
    }

    PriorityQueue.prototype.peek = function() {
        return this.queue[this.queue.length - 1];
    }

    PriorityQueue.prototype.size = function() {
        return this.queue.length;
    }

    PriorityQueue.prototype.isEmpty = function() {
        return this.queue.length === 0;
    }
};