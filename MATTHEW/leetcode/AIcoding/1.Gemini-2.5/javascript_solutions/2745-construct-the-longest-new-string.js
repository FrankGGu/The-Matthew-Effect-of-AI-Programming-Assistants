var longestString = function(x, y, z) {
    let countA = x; // Number of 'AA' blocks
    let countB = y; // Number of 'BB' blocks
    let countAB = z; // Number of 'AB' blocks

    // The 'AB' blocks are perfectly balanced and contribute to the alternating pattern.
    // Each 'AB' block provides one 'A' and one 'B'.
    // The 'AA' blocks provide two 'A's.
    // The 'BB' blocks provide two 'B's.

    // Let's consider the total number of 'A' characters and 'B' characters we can form.
    // Each 'AA' block can be thought of as providing two 'A's.
    // Each 'BB' block can be thought of as providing two 'B's.
    // Each 'AB' block can be thought of as providing one 'A' and one 'B'.

    // The problem asks for the longest string such that no two adjacent characters are the same.
    // This implies an alternating string like "ABABAB..." or "BABABA...".
    // In such a string, the count of 'A's and 'B's can differ by at most 1.

    // We can use all 'AB' blocks directly, as they already satisfy the alternating condition.
    // These `z` blocks contribute `z` 'A's and `z` 'B's to our pool of characters.
    // The `x` 'AA' blocks contribute `2x` 'A's.
    // The `y` 'BB' blocks contribute `2y` 'B's.

    // Total effective 'A' characters available for the alternating string:
    let totalEffectiveA = 2 * x + z;
    // Total effective 'B' characters available for the alternating string:
    let totalEffectiveB = 2 * y + z;

    // The maximum length of an alternating string with `N_A` 'A's and `N_B` 'B's is:
    // 2 * min(N_A, N_B) if N_A == N_B
    // 2 * min(N_A, N_B) + 1 if N_A != N_B
    // This can be combined into: 2 * Math.min(N_A, N_B) + (N_A !== N_B ? 1 : 0)

    let minCount = Math.min(totalEffectiveA, totalEffectiveB);
    let maxLength = 2 * minCount;

    // If the counts of 'A' and 'B' are different, we can add one more character
    // (the one that is more abundant) to the end of the string.
    if (totalEffectiveA !== totalEffectiveB) {
        maxLength += 1;
    }

    return maxLength;
};