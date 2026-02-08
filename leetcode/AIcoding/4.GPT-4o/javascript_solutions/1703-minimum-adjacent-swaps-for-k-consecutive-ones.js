var minMoves = function(arr, K) {
    const n = arr.length;
    const positions = [];

    for (let i = 0; i < n; i++) {
        if (arr[i] === 1) positions.push(i);
    }

    const m = positions.length;
    if (m < K) return -1;

    const prefixSum = new Array(m + 1).fill(0);
    for (let i = 1; i <= m; i++) {
        prefixSum[i] = prefixSum[i - 1] + positions[i - 1];
    }

    let minMoves = Infinity;

    for (let i = K - 1; i < m; i++) {
        const mid = i - K + 1;
        const left = positions[mid];
        const right = positions[i];
        const totalOnes = prefixSum[i + 1] - prefixSum[mid];
        const expectedPos = left + Math.floor(K / 2);
        const moves = (totalOnes - (expectedPos * (K))) + (expectedPos * (K - 1) - (totalOnes - (right * (K))));
        minMoves = Math.min(minMoves, moves);
    }

    return minMoves;
};