function constructGrid(m, n, values) {
    const grid = Array.from({ length: m }, () => Array(n).fill(0));
    let index = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            grid[i][j] = values[index++];
        }
    }

    return grid;
}