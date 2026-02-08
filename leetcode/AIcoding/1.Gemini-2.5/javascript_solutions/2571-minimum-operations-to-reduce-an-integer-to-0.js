var minOperations = function(n) {
    const memo = new Map();

    function solve(num) {
        if (num === 0) {
            return 0;
        }

        // If num is a power of 2 (and num > 0), it takes 1 operation (subtract num itself).
        // This also serves as a crucial base case to prevent cycles, e.g., for num=1 or num=2.
        if ((num & (num - 1)) === 0) {
            return 1;
        }

        if (memo.has(num)) {
            return memo.get(num);
        }

        let result;
        if (num % 2 === 0) { // num is even
            // If num is even, its least significant bit is 0.
            // Any operation +/- 2^k on num can be viewed as +/- 2^(k-1) on num/2.
            // The number of operations remains the same.
            result = solve(num / 2);
        } else { // num is odd
            // If num is odd, its least significant bit is 1.
            // We must either add 1 (2^0) or subtract 1 (2^0) to make it even.
            // Then we proceed with the resulting even number.
            result = 1 + Math.min(solve(num - 1), solve(num + 1));
        }

        memo.set(num, result);
        return result;
    }

    return solve(n);
};