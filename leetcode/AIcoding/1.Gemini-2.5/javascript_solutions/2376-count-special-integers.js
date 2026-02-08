var countSpecialIntegers = function(n) {
    const s = String(n);
    const len = s.length;

    // memo[idx][mask][isLess][isZero]
    // idx: current digit position (0 to len-1)
    // mask: bitmask representing digits used so far (0-9)
    // isLess: boolean, true if the number formed so far is already strictly less than the prefix of 's'
    // isZero: boolean, true if all digits placed so far are 0 (i.e., we are effectively placing leading zeros or building the number 0 itself)
    const memo = new Array(len).fill(0).map(() => 
                 new Array(1 << 10).fill(0).map(() => 
                 new Array(2).fill(0).map(() => 
                 new Array(2).fill(-1))));

    function dp(idx, mask, isLess, isZero) {
        if (idx === len) {
            // If isZero is true, it means we only placed leading zeros (e.g., "00" for len=2),
            // which does not form a positive integer.
            // Otherwise, we formed a valid special integer.
            return isZero ? 0 : 1;
        }

        if (memo[idx][mask][isLess][isZero] !== -1) {
            return memo[idx][mask][isLess][isZero];
        }

        let ans = 0;
        const upperBound = isLess ? 9 : parseInt(s[idx]);

        for (let digit = 0; digit <= upperBound; digit++) {
            if (isZero && digit === 0) {
                // Still placing leading zeros. The number hasn't started yet.
                // The 'isLess' flag updates based on whether the current digit (0) is less than s[idx].
                // If s[idx] is '0', then digit < upperBound is false. If s[idx] is '1' or more, it's true.
                ans += dp(idx + 1, mask, isLess || (digit < upperBound), true);
            } else {
                // Number has started (either current digit is non-zero, or it's a subsequent digit after a non-zero).
                // Check if the digit has been used before.
                if (!((mask >> digit) & 1)) {
                    // Digit is unique, add it to the mask and continue.
                    // 'isZero' becomes false because a non-zero digit has been placed.
                    ans += dp(idx + 1, mask | (1 << digit), isLess || (digit < upperBound), false);
                }
            }
        }

        return memo[idx][mask][isLess][isZero] = ans;
    }

    // Start the DP process from the first digit (index 0).
    // Initial state:
    // idx=0: Starting from the first digit.
    // mask=0: No digits used yet.
    // isLess=false: The number being built is not yet guaranteed to be less than 'n'.
    // isZero=true: We are initially in a state where leading zeros could be placed (this handles numbers with fewer digits than 'n').
    return dp(0, 0, false, true);
};