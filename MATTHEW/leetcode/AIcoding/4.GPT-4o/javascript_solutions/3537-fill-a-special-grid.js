function fillGrid(A, B) {
    const grid = Array.from({ length: A }, () => Array(B).fill(0));
    for (let i = 0; i < A; i++) {
        for (let j = 0; j < B; j++) {
            if ((i % 2 === 0 && j % 2 === 0) || (i % 2 === 1 && j % 2 === 1)) {
                grid[i][j] = 1;
            }
        }
    }
    return grid;
}