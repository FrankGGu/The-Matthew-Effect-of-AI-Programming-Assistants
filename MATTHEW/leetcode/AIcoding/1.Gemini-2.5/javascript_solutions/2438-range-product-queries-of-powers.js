var productQueries = function(n, queries) {
    const MOD = 1000000007;
    const powers = [];
    let currentPowerOf2 = 1;

    // Generate the powers array by checking each bit of n
    // If the i-th bit of n is set, then 2^i is one of the powers.
    // The powers array will be naturally sorted in ascending order.
    for (let i = 0; i < 31; i++) { // Max n is 10^9, which is less than 2^30. So 30 bits are sufficient.
        if ((n >> i) & 1) { // Check if the i-th bit is 1
            powers.push(currentPowerOf2);
        }
        currentPowerOf2 *= 2;
    }

    const results = [];

    // Process each query
    for (const query of queries) {
        const left = query[0];
        const right = query[1];
        let currentProduct = 1;

        // Calculate the product of powers[left] through powers[right] modulo MOD
        for (let i = left; i <= right; i++) {
            currentProduct = (currentProduct * powers[i]) % MOD;
        }
        results.push(currentProduct);
    }

    return results;
};