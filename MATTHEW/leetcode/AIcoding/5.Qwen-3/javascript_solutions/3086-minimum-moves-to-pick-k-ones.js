function minMovesToPickKOnes(arr, k) {
    const n = arr.length;
    const positions = [];
    for (let i = 0; i < n; i++) {
        if (arr[i] === 1) {
            positions.push(i);
        }
    }
    const m = positions.length;
    if (k === 0) return 0;
    if (m < k) return -1;
    let minMoves = Infinity;
    for (let i = 0; i <= m - k; i++) {
        const left = positions[i];
        const right = positions[i + k - 1];
        const mid = positions[i + Math.floor((k - 1) / 2)];
        let moves = 0;
        for (let j = i; j <= i + k - 1; j++) {
            moves += Math.abs(positions[j] - mid);
        }
        minMoves = Math.min(minMoves, moves);
    }
    return minMoves;
}