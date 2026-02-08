var shortestSubarray = function(A, K) {
    const n = A.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] | A[i];
    }

    const deque = [];
    let minLength = Infinity;

    for (let i = 0; i <= n; i++) {
        while (deque.length && prefix[i] >= K) {
            minLength = Math.min(minLength, i - deque.shift());
        }
        while (deque.length && prefix[deque[deque.length - 1]] >= prefix[i]) {
            deque.pop();
        }
        deque.push(i);
    }

    return minLength === Infinity ? -1 : minLength;
};