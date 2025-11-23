var minimumPossibleSum = function(n, target) {
    let N = BigInt(n);
    let TARGET = BigInt(target);

    // Calculate `count_small`: the number of integers we can pick from 1, 2, ...
    // such that they are all strictly less than TARGET / 2.
    // This value is `floor((TARGET - 1) / 2)`.
    // We pick at most `N` such numbers.
    let max_small_to_pick = (TARGET - 1n) / 2n;
    let count_small = N < max_small_to_pick ? N : max_small_to_pick;

    // The sum of the first `count_small` numbers (1, 2, ..., count_small).
    // These numbers are guaranteed to be part of the beautiful array as they are all < TARGET / 2,
    // and thus their complements (TARGET - x) are all > TARGET / 2.
    let result = count_small * (count_small + 1n) / 2n;

    // Calculate the remaining number of elements we need to pick.
    let remaining_n = N - count_small;

    if (remaining_n > 0n) {
        // We need to pick `remaining_n` more numbers.
        // The numbers `1, ..., count_small` have been picked.
        // The numbers `TARGET - 1, ..., TARGET - count_small` are forbidden.

        // Consider the next number we would typically pick: `count_small + 1`.
        // We need to check if `count_small + 1` is forbidden.
        // `count_small + 1` is forbidden if `count_small + 1 == TARGET - count_small`.
        // This equality simplifies to `2 * count_small + 1 == TARGET`.
        // This condition holds true if and only if `TARGET` is an odd number.

        if (TARGET % 2n !== 0n) { // TARGET is odd
            // In this case, `count_small + 1` is equal to `TARGET - count_small`,
            // meaning `count_small + 1` is forbidden.
            // So, we must skip `count_small + 1` and all subsequent forbidden numbers.
            // The smallest available number after `count_small` that is not forbidden is `TARGET`.
            // We pick `remaining_n` numbers starting from `TARGET`:
            // `TARGET, TARGET + 1, ..., TARGET + remaining_n - 1`.
            let first_num_after = TARGET;
            let last_num_after = TARGET + remaining_n - 1n;
            result += (first_num_after + last_num_after) * remaining_n / 2n;
        } else { // TARGET is even
            // In this case, `count_small + 1` is `TARGET / 2`.
            // `TARGET - count_small` is `TARGET / 2 + 1`.
            // So, `count_small + 1` (`TARGET / 2`) is available and not forbidden.
            // We pick `count_small + 1`.
            result += (count_small + 1n);
            remaining_n--; // One number picked, `remaining_n` decreases.

            // If there are still numbers to pick, they must start from `TARGET`.
            // This is because `count_small + 2` (which is `TARGET / 2 + 1`) is `TARGET - count_small`,
            // making it the first forbidden number. So we skip to `TARGET`.
            if (remaining_n > 0n) {
                let first_num_after = TARGET;
                let last_num_after = TARGET + remaining_n - 1n;
                result += (first_num_after + last_num_after) * remaining_n / 2n;
            }
        }
    }

    // Convert the BigInt result back to a Number.
    // Note: If the result exceeds Number.MAX_SAFE_INTEGER, precision might be lost.
    // LeetCode problems usually imply the result fits or handle BigInt return types.
    return Number(result);
};