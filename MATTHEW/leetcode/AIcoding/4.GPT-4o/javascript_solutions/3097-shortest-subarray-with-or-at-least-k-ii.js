function shortestSubarray(A, K) {
    const N = A.length;
    const prefix = new Array(N + 1).fill(0);
    for (let i = 0; i < N; i++) {
        prefix[i + 1] = prefix[i] | A[i];
    }

    const deque = [];
    let result = Infinity;

    for (let i = 0; i <= N; i++) {
        while (deque.length && prefix[i] >= K) {
            result = Math.min(result, i - deque.shift());
        }
        while (deque.length && prefix[deque[deque.length - 1]] <= prefix[i]) {
            deque.pop();
        }
        deque.push(i);
    }

    return result === Infinity ? -1 : result;
}