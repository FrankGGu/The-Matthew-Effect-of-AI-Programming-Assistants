var constructProductMatrix = function(grid) {
    const MOD = 12345;
    const m = grid.length;
    const n = grid[0].length;
    const total = m * n;
    const prefix = new Array(total).fill(1);
    const suffix = new Array(total).fill(1);
    const res = new Array(m).fill().map(() => new Array(n).fill(1));

    let product = 1;
    for (let i = 0; i < total; i++) {
        const row = Math.floor(i / n);
        const col = i % n;
        prefix[i] = product;
        product = (product * grid[row][col]) % MOD;
    }

    product = 1;
    for (let i = total - 1; i >= 0; i--) {
        const row = Math.floor(i / n);
        const col = i % n;
        suffix[i] = product;
        product = (product * grid[row][col]) % MOD;
    }

    for (let i = 0; i < total; i++) {
        const row = Math.floor(i / n);
        const col = i % n;
        res[row][col] = (prefix[i] * suffix[i]) % MOD;
    }

    return res;
};