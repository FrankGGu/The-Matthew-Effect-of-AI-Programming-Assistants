function maxValueOfCoins(piles, k) {
    // dp[j] will store the maximum value obtained using exactly 'j' coins.
    // Initialize dp array with zeros. dp[0] = 0 means 0 coins yield 0 value.
    const dp = new Array(k + 1).fill(0);

    // Iterate through each pile
    for (const pile of piles) {
        // Calculate prefix sums for the current pile to efficiently get sum of first 'c' coins.
        // currentPilePrefixSums[x] will store the sum of the first x coins in the current pile.
        // currentPilePrefixSums[0] is 0 (representing taking 0 coins from the pile).
        const currentPilePrefixSums = new Array(pile.length + 1).fill(0);
        for (let i = 0; i < pile.length; i++) {
            currentPilePrefixSums[i + 1] = currentPilePrefixSums[i] + pile[i];
        }

        // Iterate 'j' from 'k' down to '0'.
        // 'j' represents the total number of coins we are trying to achieve.
        // We iterate downwards to ensure that when we calculate dp[j],
        // dp[j - c] refers to the maximum value using 'j - c' coins from *previous* piles,
        // not from the current pile (which would be an incorrect re-use of current pile coins).
        for (let j = k; j >= 0; j--) {
            // Iterate 'c' from '0' up to 'min(j, pile.length)'.
            // 'c' represents the number of coins we decide to take from the *current* pile.
            // We cannot take more coins than available in the pile (pile.length).
            // We cannot take more coins than 'j' (the total coins we want to achieve).
            for (let c = 0; c <= Math.min(j, pile.length); c++) {
                // If we take 'c' coins from the current pile:
                // 1. Their value is currentPilePrefixSums[c].
                // 2. The remaining 'j - c' coins must have been taken from previous piles.
                //    The maximum value for these 'j - c' coins is dp[j - c].
                // We update dp[j] with the maximum of its current value and the new combination.
                dp[j] = Math.max(dp[j], dp[j - c] + currentPilePrefixSums[c]);
            }
        }
    }

    // After iterating through all piles, dp[k] will hold the maximum value
    // obtained by choosing exactly 'k' coins.
    return dp[k];
}