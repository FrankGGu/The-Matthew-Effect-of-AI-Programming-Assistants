var numberOfBeautifulPartitions = function(s, k) {
    const n = s.length;
    const MOD = 10 ** 9 + 7;

    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    const isVowel = (char) => vowels.has(char);
    const isConsonant = (char) => !vowels.has(char);

    // Initial checks for impossible cases
    // 1. The first character of the entire string must be a vowel.
    // 2. The last character of the entire string must be a consonant.
    if (!isVowel(s[0]) || !isConsonant(s[n - 1])) {
        return 0;
    }
    // 3. Each partition must have a length of at least 2.
    // So, k partitions require a string length of at least 2*k.
    if (k * 2 > n) {
        return 0;
    }

    // dp[i][j] will store the number of ways to partition s[0...i-1] into j beautiful partitions.
    // i ranges from 0 to n (representing prefix length).
    // j ranges from 0 to k (representing number of partitions).
    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(0));

    // Base case: There is 1 way to partition an empty string (prefix of length 0) into 0 partitions.
    dp[0][0] = 1;

    // Iterate through the number of partitions (j)
    for (let j = 1; j <= k; j++) {
        // prefix_sum_dp_prev_j_array[idx] will store the sum of dp[x][j-1] for x from 0 to idx-1
        // where s[x] is a vowel. This sum represents the number of ways to form j-1 partitions
        // ending at s[x-1], such that s[x] is a vowel and can start a new partition.
        const prefix_sum_dp_prev_j_array = Array(n + 1).fill(0);

        // Iterate through the string prefixes (i)
        for (let i = 1; i <= n; i++) {
            // Update prefix_sum_dp_prev_j_array[i] based on the previous index.
            // prefix_sum_dp_prev_j_array[i] will accumulate valid previous states.
            prefix_sum_dp_prev_j_array[i] = prefix_sum_dp_prev_j_array[i - 1];

            // If the character s[i-1] (which is the character at index i-1 in the original string) is a vowel,
            // then dp[i-1][j-1] (number of ways to partition s[0...i-2] into j-1 partitions)
            // becomes a potential starting point for the j-th partition.
            // Add it to the running sum for future calculations.
            if (isVowel(s[i - 1])) {
                prefix_sum_dp_prev_j_array[i] = (prefix_sum_dp_prev_j_array[i] + dp[i - 1][j - 1]) % MOD;
            }

            // If s[i-1] is a consonant, it can be the end of a beautiful partition.
            // A beautiful partition s[p...i-1] must satisfy:
            // 1. s[p] is a vowel.
            // 2. s[i-1] is a consonant (checked here).
            // 3. Length >= 2, which means p <= i-2.
            // So, dp[i][j] is the sum of dp[p][j-1] for all valid p from 0 to i-2 where s[p] is a vowel.
            // This sum is precisely what prefix_sum_dp_prev_j_array[i-1] holds.
            if (isConsonant(s[i - 1])) {
                // Ensure there are at least 2 characters for the current partition (s[p...i-1]).
                // This means i-1 - p + 1 >= 2, or i - p >= 2. Since p >= 0, i must be at least 2.
                if (i >= 2) {
                    dp[i][j] = prefix_sum_dp_prev_j_array[i - 1];
                }
            }
        }
    }

    // The final answer is the number of ways to partition the entire string s (prefix of length n)
    // into k beautiful partitions.
    return dp[n][k];
};