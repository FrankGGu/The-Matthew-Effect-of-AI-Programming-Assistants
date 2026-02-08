var findRotateSteps = function(ring, key) {
    const ringLen = ring.length;
    const keyLen = key.length;

    // Precompute indices for each character in the ring
    // charIndices[char_code - 'a'.charCodeAt(0)] will be a list of indices where this char appears in ring.
    const charIndices = new Array(26).fill(0).map(() => []);
    for (let i = 0; i < ringLen; i++) {
        charIndices[ring.charCodeAt(i) - 'a'.charCodeAt(0)].push(i);
    }

    // Memoization table: dp[k_idx][r_idx] stores the minimum steps
    // to spell key[k_idx...] given that ring[r_idx] is currently at the 12 o'clock position.
    const memo = new Array(keyLen).fill(0).map(() => new Array(ringLen).fill(-1));

    // Recursive DP function
    // k_idx: current index in the key string we are trying to spell
    // r_idx: current index in the ring string that is at the 12 o'clock position
    function solve(k_idx, r_idx) {
        // Base case: if all characters in key are spelled, no more steps needed.
        if (k_idx === keyLen) {
            return 0;
        }

        // If this state has already been computed, return the memoized result.
        if (memo[k_idx][r_idx] !== -1) {
            return memo[k_idx][r_idx];
        }

        let minTotalSteps = Infinity;
        const targetChar = key[k_idx];
        const indicesOfTargetChar = charIndices[targetChar.charCodeAt(0) - 'a'.charCodeAt(0)];

        // Iterate through all occurrences of the targetChar in the ring
        for (const next_r_idx of indicesOfTargetChar) {
            // Calculate the rotation cost to bring ring[next_r_idx] to 12 o'clock
            // from the current ring[r_idx] at 12 o'clock.
            const dist = Math.abs(r_idx - next_r_idx);
            const rotationCost = Math.min(dist, ringLen - dist);

            // Total steps for this character: rotation cost + 1 (for pressing the button)
            const stepsForThisChar = rotationCost + 1;

            // Recursively find the minimum steps for the remaining key characters
            // starting from the new ring position (next_r_idx).
            const remainingSteps = solve(k_idx + 1, next_r_idx);

            // Update the minimum total steps for the current state.
            minTotalSteps = Math.min(minTotalSteps, stepsForThisChar + remainingSteps);
        }

        // Memoize the result before returning.
        memo[k_idx][r_idx] = minTotalSteps;
        return minTotalSteps;
    }

    // Start the DP from the first character of the key (k_idx = 0),
    // with ring[0] initially at the 12 o'clock position (r_idx = 0).
    return solve(0, 0);
};