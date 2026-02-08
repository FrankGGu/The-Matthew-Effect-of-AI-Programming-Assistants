var consecutiveNumbersSum = function(N) {
    let count = 0;

    // We are looking for N = x + (x+1) + ... + (x+k-1)
    // where x >= 1 and k >= 1.
    // The sum of an arithmetic progression is k/2 * (first + last)
    // N = k/2 * (x + x + k - 1)
    // N = k/2 * (2x + k - 1)
    // 2N = k * (2x + k - 1)

    // Let M = 2x + k - 1.
    // So, 2N = k * M.

    // From x >= 1:
    // 2x >= 2
    // M = 2x + k - 1 >= 2 + k - 1 = k + 1.
    // Thus, M > k.

    // Also, k and M must have different parities:
    // If k is odd: M = 2x + (odd - 1) = 2x + even = even. (k=odd, M=even)
    // If k is even: M = 2x + (even - 1) = 2x + odd = odd. (k=even, M=odd)
    // In both cases, (k + M) will be odd, so (k + M) % 2 === 1.

    // We iterate through possible values of k.
    // The condition M > k implies k * M > k * k.
    // Since k * M = 2N, we have 2N > k * k, or k * k < 2N.
    // This gives us an upper bound for k.
    for (let k = 1; k * k < 2 * N; k++) {
        // Check if k is a divisor of 2N
        if ((2 * N) % k === 0) {
            let M = (2 * N) / k;
            // Check if k and M have different parities
            if ((k + M) % 2 === 1) {
                count++;
            }
        }
    }

    return count;
};