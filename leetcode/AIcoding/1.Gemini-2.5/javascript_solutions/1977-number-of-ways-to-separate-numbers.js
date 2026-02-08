var numberOfWays = function(num) {
    const N = num.length;
    const MOD = 10 ** 9 + 7;

    // lcp[i][j] stores the length of the longest common prefix of num.substring(i) and num.substring(j)
    // This is used for efficient lexicographical string comparison.
    const lcp = Array(N + 1).fill(0).map(() => Array(N + 1).fill(0));

    for (let i = N - 1; i >= 0; i--) {
        for (let j = N - 1; j >= 0; j--) {
            if (num[i] === num[j]) {
                lcp[i][j] = 1 + lcp[i + 1][j + 1];
            } else {
                lcp[i][j] = 0;
            }
        }
    }

    // compare(idx1, idx2, len) returns true if num.substring(idx1, idx1 + len) <= num.substring(idx2, idx2 + len)
    const compare = (idx1, idx2, len) => {
        const commonPrefixLen = lcp[idx1][idx2];
        if (commonPrefixLen >= len) {
            return true; // strings are equal
        }
        return num[idx1 + commonPrefixLen] < num[idx2 + commonPrefixLen];
    };

    // dp[i][j] stores the number of ways to separate num[0...i-1] such that the last number num[i-j...i-1] has length j.
    const dp = Array(N + 1).fill(0).map(() => Array(N + 1).fill(0));

    // sum_dp[i][j] stores the sum of dp[i][k] for k from 1 to j.
    // This is a prefix sum for the dp[i] row, used to efficiently sum ways for shorter previous numbers.
    const sum_dp = Array(N + 1).fill(0).map(() => Array(N + 1).fill(0));

    for (let i = 1; i <= N; i++) { // i is the current end index (exclusive)
        for (let j = 1; j <= i; j++) { // j is the length of the current number num[i-j...i-1]
            const currentNumStartIdx = i - j;

            // Rule: Numbers cannot have leading zeros (e.g., "03" is invalid, "0" is valid).
            if (num[currentNumStartIdx] === '0' && j > 1) {
                dp[i][j] = 0; // Invalid number like "01", "00"
            } else {
                if (currentNumStartIdx === 0) { // This is the first number in the sequence
                    dp[i][j] = 1;
                } else {
                    const prevIdx = currentNumStartIdx; // The end index of the previous number (exclusive)
                    const prevMaxLen = prevIdx; // The maximum possible length for a previous number ending at prevIdx-1

                    // Case 1: Previous number has length 'prevLen' < j (shorter than current number)
                    // These are always valid (prevNum < currentNum).
                    // Sum dp[prevIdx][prevLen] for prevLen from 1 to min(prevMaxLen, j-1).
                    // This sum is efficiently obtained from sum_dp[prevIdx][Math.min(prevMaxLen, j-1)].
                    dp[i][j] = (dp[i][j] + sum_dp[prevIdx][Math.min(prevMaxLen, j - 1)]) % MOD;

                    // Case 2: Previous number has length 'prevLen' == j (same length as current number)
                    // We need to compare them lexicographically to ensure non-decreasing order.
                    if (j <= prevMaxLen) { // A previous number of length j is possible
                        const prevNumStartIdx = prevIdx - j;
                        if (compare(prevNumStartIdx, currentNumStartIdx, j)) {
                            dp[i][j] = (dp[i][j] + dp[prevIdx][j]) % MOD;
                        }
                    }
                    // Case 3: Previous number has length 'prevLen' > j (longer than current number)
                    // These are always invalid (prevNum > currentNum), so they do not contribute.
                }
            }

            // Update prefix sum for dp[i] for the current row
            sum_dp[i][j] = (sum_dp[i][j - 1] + dp[i][j]) % MOD;
        }
    }

    // The total number of ways to separate num[0...N-1] is the sum of all dp[N][j] for j from 1 to N.
    // This total sum is stored in sum_dp[N][N].
    return sum_dp[N][N];
};