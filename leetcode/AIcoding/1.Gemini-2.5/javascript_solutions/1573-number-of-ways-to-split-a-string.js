var numWays = function(s) {
    const n = s.length;
    const MOD = 10**9 + 7;

    let totalOnes = 0;
    for (let i = 0; i < n; i++) {
        if (s[i] === '1') {
            totalOnes++;
        }
    }

    if (totalOnes % 3 !== 0) {
        return 0;
    }

    if (totalOnes === 0) {
        // If there are no '1's, any split into three non-empty parts is valid.
        // We need to choose 2 cut points from n-1 possible positions.
        // The number of ways is (n-1 choose 2) = (n-1) * (n-2) / 2.
        // We need n >= 3 for this to be possible.
        if (n < 3) {
            return 0;
        }
        const ways = BigInt(n - 1) * BigInt(n - 2) / BigInt(2);
        return Number(ways % BigInt(MOD));
    }

    const targetOnes = totalOnes / 3;

    let indicesOfOnes = [];
    for (let i = 0; i < n; i++) {
        if (s[i] === '1') {
            indicesOfOnes.push(i);
        }
    }

    // The first cut `i` (0 < i < j < n) separates s[0...i-1] from s[i...n-1].
    // s[0...i-1] must contain `targetOnes` '1's.
    // This means the `targetOnes`-th '1' (0-indexed `indicesOfOnes[targetOnes - 1]`)
    // must be at an index less than `i`.
    // And the `(targetOnes + 1)`-th '1' (0-indexed `indicesOfOnes[targetOnes]`)
    // must be at an index greater than or equal to `i`.
    // So, `indicesOfOnes[targetOnes - 1] < i <= indicesOfOnes[targetOnes]`.
    // The number of choices for `i` is `indicesOfOnes[targetOnes] - indicesOfOnes[targetOnes - 1]`.
    const numWaysFirstCut = BigInt(indicesOfOnes[targetOnes] - indicesOfOnes[targetOnes - 1]);

    // The second cut `j` separates s[0...j-1] from s[j...n-1].
    // s[0...j-1] must contain `2 * targetOnes` '1's.
    // This means the `(2 * targetOnes)`-th '1' (0-indexed `indicesOfOnes[2 * targetOnes - 1]`)
    // must be at an index less than `j`.
    // And the `(2 * targetOnes + 1)`-th '1' (0-indexed `indicesOfOnes[2 * targetOnes]`)
    // must be at an index greater than or equal to `j`.
    // So, `indicesOfOnes[2 * targetOnes - 1] < j <= indicesOfOnes[2 * targetOnes]`.
    // The number of choices for `j` is `indicesOfOnes[2 * targetOnes] - indicesOfOnes[2 * targetOnes - 1]`.
    const numWaysSecondCut = BigInt(indicesOfOnes[2 * targetOnes] - indicesOfOnes[2 * targetOnes - 1]);

    return Number((numWaysFirstCut * numWaysSecondCut) % BigInt(MOD));
};