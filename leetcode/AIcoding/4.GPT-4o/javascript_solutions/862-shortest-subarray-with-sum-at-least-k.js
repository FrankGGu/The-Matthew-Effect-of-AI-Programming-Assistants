function shortestSubarray(A, K) {
    const n = A.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + A[i];
    }

    const deque = [];
    let minLength = Infinity;

    for (let i = 0; i <= n; i++) {
        while (deque.length && prefixSum[i] - prefixSum[deque[0]] >= K) {
            minLength = Math.min(minLength, i - deque.shift());
        }

        while (deque.length && prefixSum[i] <= prefixSum[deque[deque.length - 1]]) {
            deque.pop();
        }

        deque.push(i);
    }

    return minLength === Infinity ? -1 : minLength;
}