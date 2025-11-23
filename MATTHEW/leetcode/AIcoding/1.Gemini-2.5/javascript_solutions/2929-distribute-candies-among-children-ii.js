var distributeCandies = function(n, limit) {
    // Helper function for combinations C(k, 2)
    // C(k, 2) = k * (k - 1) / 2
    // If k < 2, C(k, 2) is 0.
    // This function expects k to be a BigInt.
    const combinations2 = (kBigInt) => {
        if (kBigInt < 2n) {
            return 0n;
        }
        return kBigInt * (kBigInt - 1n) / 2n;
    };

    // Convert n and limit to BigInt for accurate calculations,
    // as intermediate results can exceed Number.MAX_SAFE_INTEGER.
    const N = BigInt(n);
    const LIMIT = BigInt(limit);

    // Apply the Principle of Inclusion-Exclusion.
    // We want to find the number of non-negative integer solutions to x1 + x2 + x3 = n
    // such that 0 <= x1, x2, x3 <= limit.

    // 1. Total ways to distribute n candies among 3 children without any upper limit:
    // This is a stars and bars problem: C(n + k - 1, k - 1) where k=3 children.
    // So, C(n + 3 - 1, 3 - 1) = C(n + 2, 2).
    let ans = combinations2(N + 2n);

    // 2. Subtract cases where at least one child exceeds the limit (x_i >= limit + 1).
    // Consider x1 >= limit + 1. Let x1' = x1 - (limit + 1).
    // The equation becomes (x1' + limit + 1) + x2 + x3 = n
    // => x1' + x2 + x3 = n - (limit + 1).
    // The number of solutions for this is C(n - (limit + 1) + 2, 2) = C(n - limit + 1, 2).
    // Since there are 3 children, we multiply this by 3.
    ans -= 3n * combinations2(N - LIMIT + 1n);

    // 3. Add back cases where at least two children exceed the limit (x_i >= limit + 1, x_j >= limit + 1).
    // Consider x1 >= limit + 1 and x2 >= limit + 1. Let x1' = x1 - (limit + 1), x2' = x2 - (limit + 1).
    // The equation becomes (x1' + limit + 1) + (x2' + limit + 1) + x3 = n
    // => x1' + x2' + x3 = n - 2 * (limit + 1).
    // The number of solutions for this is C(n - 2 * (limit + 1) + 2, 2) = C(n - 2 * limit, 2).
    // There are 3 pairs of children ((x1,x2), (x1,x3), (x2,x3)), so we multiply by 3.
    ans += 3n * combinations2(N - 2n * LIMIT);

    // 4. Subtract cases where all three children exceed the limit (x_i >= limit + 1 for all i).
    // Consider x1, x2, x3 >= limit + 1. Let x1' = x1 - (limit + 1), etc.
    // The equation becomes (x1' + limit + 1) + (x2' + limit + 1) + (x3' + limit + 1) = n
    // => x1' + x2' + x3' = n - 3 * (limit + 1).
    // The number of solutions for this is C(n - 3 * (limit + 1) + 2, 2) = C(n - 3 * limit - 1, 2).
    // There is only 1 such case (all three children).
    ans -= combinations2(N - 3n * LIMIT - 1n);

    // Convert the BigInt result back to a Number as required by the problem.
    return Number(ans);
};