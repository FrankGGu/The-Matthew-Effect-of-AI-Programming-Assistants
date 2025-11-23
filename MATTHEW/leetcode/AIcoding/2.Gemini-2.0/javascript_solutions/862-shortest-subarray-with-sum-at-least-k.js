var shortestSubarray = function(A, K) {
    const n = A.length;
    let minLen = n + 1;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + A[i];
    }

    const deque = [];
    for (let i = 0; i <= n; i++) {
        while (deque.length > 0 && prefixSum[i] - prefixSum[deque[0]] >= K) {
            minLen = Math.min(minLen, i - deque.shift());
        }
        while (deque.length > 0 && prefixSum[i] <= prefixSum[deque[deque.length - 1]]) {
            deque.pop();
        }
        deque.push(i);
    }

    return minLen > n ? -1 : minLen;
};