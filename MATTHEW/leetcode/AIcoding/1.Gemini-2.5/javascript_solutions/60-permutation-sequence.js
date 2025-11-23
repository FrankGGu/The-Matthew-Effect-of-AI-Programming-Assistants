var getPermutation = function(n, k) {
    const factorials = new Array(n + 1).fill(1);
    const digits = [];

    for (let i = 1; i <= n; i++) {
        factorials[i] = factorials[i - 1] * i;
        digits.push(i);
    }

    let result = "";
    k--; 

    for (let i = n; i >= 1; i--) {
        const block_size = factorials[i - 1];
        const idx = Math.floor(k / block_size);

        result += digits[idx];
        digits.splice(idx, 1); 

        k %= block_size;
    }

    return result;
};