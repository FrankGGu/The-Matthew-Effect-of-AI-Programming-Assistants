var constructProductMatrix = function(grid) {
    const MOD = 12345;
    const R = grid.length;
    const C = grid[0].length;

    const P = Array(R).fill(0).map(() => Array(C).fill(0));

    // Pass 1: Calculate prefix products (product of all elements encountered before current cell)
    // P[i][j] will store the product of elements from grid[0][0] up to grid[i][j-1] (or grid[i-1][C-1])
    let currentProduct = 1;
    for (let i = 0; i < R; i++) {
        for (let j = 0; j < C; j++) {
            P[i][j] = currentProduct;
            currentProduct = (currentProduct * grid[i][j]) % MOD;
        }
    }

    // Pass 2: Calculate suffix products (product of all elements encountered after current cell)
    // and multiply with the prefix products already stored in P
    currentProduct = 1;
    for (let i = R - 1; i >= 0; i--) {
        for (let j = C - 1; j >= 0; j--) {
            P[i][j] = (P[i][j] * currentProduct) % MOD;
            currentProduct = (currentProduct * grid[i][j]) % MOD;
        }
    }

    return P;
};