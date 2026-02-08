var constructDistancedSequence = function(n) {
    const len = 2 * n - 1;
    const ans = new Array(len).fill(0);
    const used = new Array(n + 1).fill(false); // used[i] is true if number i has been placed

    function backtrack(idx) {
        if (idx === len) {
            return true; // All positions filled, a valid sequence found
        }

        if (ans[idx] !== 0) {
            // This position is already filled by a previous placement (e.g., ans[idx - num] = num)
            return backtrack(idx + 1);
        }

        // Try placing numbers from 1 to n to ensure lexicographical smallest
        for (let num = 1; num <= n; num++) {
            if (!used[num]) { // If num has not been fully placed yet
                if (num === 1) {
                    ans[idx] = 1;
                    used[1] = true;
                    if (backtrack(idx + 1)) {
                        return true;
                    }
                    // Backtrack
                    used[1] = false;
                    ans[idx] = 0;
                } else { // num > 1
                    const secondIdx = idx + num;
                    // Check if second position is within bounds and is empty
                    if (secondIdx < len && ans[secondIdx] === 0) {
                        ans[idx] = num;
                        ans[secondIdx] = num;
                        used[num] = true;
                        if (backtrack(idx + 1)) {
                            return true;
                        }
                        // Backtrack
                        used[num] = false;
                        ans[idx] = 0;
                        ans[secondIdx] = 0;
                    }
                }
            }
        }
        return false; // No number could be placed at this position
    }

    backtrack(0);
    return ans;
};