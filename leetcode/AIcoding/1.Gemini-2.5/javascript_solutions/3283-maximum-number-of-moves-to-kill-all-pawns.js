var maximumMovesToKillAllPawns = function(nums) {
    const n = nums.length;
    if (n === 0) {
        return 0;
    }

    // dp[i] will store the maximum number of pawns killed if the player's current position is i.
    // (Assuming nums[i] is now an empty cell, or was originally a player's pawn).
    // Initialize dp array with 0s. Size n+1 to handle out-of-bounds access for next_j = n.
    const dp = new Array(n + 1).fill(0);

    // first_non_zero_to_right[i] stores the index of the first non-zero element strictly to the right of i.
    // If no such element exists, it stores n.
    const first_non_zero_to_right = new Array(n + 1).fill(n);
    let last_non_zero_seen = n; // Sentinel value indicating no non-zero elements seen yet to the right

    for (let i = n - 1; i >= 0; i--) {
        first_non_zero_to_right[i] = last_non_zero_seen;
        if (nums[i] !== 0) {
            last_non_zero_seen = i;
        }
    }

    let max_total_kills = 0;

    // Iterate from right to left to fill dp array
    for (let i = n - 1; i >= 0; i--) {
        let current_max_kills_from_i = 0;

        // Find the index of the first non-zero element to the right of i
        const next_j = first_non_zero_to_right[i];

        if (next_j < n) { // If there is a non-zero element to the right (i.e., next_j is a valid index)
            if (nums[next_j] === 1) {
                // If the first non-zero element is another player's pawn, we are blocked.
                // Cannot make any moves past it from current position i.
                current_max_kills_from_i = 0;
            } else { // nums[next_j] must be -1, as it's a non-zero element
                // If the first non-zero element is an enemy pawn, we can kill it.
                // The number of kills is 1 (for this pawn) + max kills from next_j (after it's killed and becomes empty).
                current_max_kills_from_i = 1 + dp[next_j];
            }
        }

        dp[i] = current_max_kills_from_i;

        // If nums[i] is a player's starting position, update the overall maximum kills.
        if (nums[i] === 1) {
            max_total_kills = Math.max(max_total_kills, dp[i]);
        }
    }

    return max_total_kills;
};