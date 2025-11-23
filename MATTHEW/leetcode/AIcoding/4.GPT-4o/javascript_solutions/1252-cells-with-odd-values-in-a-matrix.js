function oddCells(m, n, indices) {
    const row = new Array(m).fill(0);
    const col = new Array(n).fill(0);

    for (const [r, c] of indices) {
        row[r]++;
        col[c]++;
    }

    let oddCount = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if ((row[i] + col[j]) % 2 !== 0) {
                oddCount++;
            }
        }
    }

    return oddCount;
}