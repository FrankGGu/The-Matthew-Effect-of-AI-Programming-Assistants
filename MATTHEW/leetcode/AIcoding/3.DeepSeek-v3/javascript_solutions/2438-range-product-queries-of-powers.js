var productQueries = function(n, queries) {
    const powers = [];
    let current = 1;
    while (current <= n) {
        if (current & n) {
            powers.push(current);
        }
        current <<= 1;
    }

    const prefix = [1];
    for (const num of powers) {
        prefix.push(prefix[prefix.length - 1] * num % (1e9 + 7));
    }

    const result = [];
    for (const [left, right] of queries) {
        const product = prefix[right + 1] / prefix[left] % (1e9 + 7);
        result.push(product);
    }
    return result;
};