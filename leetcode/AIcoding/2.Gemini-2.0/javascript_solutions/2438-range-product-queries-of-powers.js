var productQueries = function(n, queries) {
    const MOD = 10**9 + 7;
    const powers = [];
    let power = 0;
    while (n > 0) {
        if (n % 2 === 1) {
            powers.push(2**power);
        }
        n = Math.floor(n / 2);
        power++;
    }

    const result = [];
    for (const query of queries) {
        let product = 1;
        for (let i = query[0]; i <= query[1]; i++) {
            product = (product * powers[i]) % MOD;
        }
        result.push(product);
    }

    return result;
};