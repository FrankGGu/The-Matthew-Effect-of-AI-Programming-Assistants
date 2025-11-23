var countBeautifulNumbers = function(low, high) {

    // Helper function to count beautiful numbers up to a given number n (inclusive).
    function solve(n) {
        // Convert n to a string to easily access its digits.
        let s = String(n);
        let N = s.length;

        // The maximum possible sum of digits for a number up to 10^9 is 9 * 9 = 81.
        // This value is used to define the upper bound for `targetSum`.
        const MAX_SUM_DIGITS = 81; 

        let totalBeautiful = 0;

        // Iterate over all possible sums of digits (from 1 to MAX_SUM_DIGITS).
        // For each possible sum, we count numbers `x` such that `sum_of_digits(x) == targetSum`
        // and `x % targetSum == 0`.
        for (let targetSum = 1; targetSum <= MAX_SUM_DIGITS; targetSum++) {
            // Memoization table for the current targetSum.
            // memo[index][current_remainder][current_sum][is_less][is_started]
            // index: current digit position (0 to N-1)
            // current_remainder: (number_formed_so_far) % targetSum (0 to targetSum-1)
            // current_sum: sum of digits placed so far (0 to targetSum)
            // is_less: boolean, true if current prefix is already less than 's' prefix
            // is_started: boolean, true if a non-zero digit has been placed
            let memo = new Array(N).fill(0).map(() => 
                new Array(targetSum).fill(0).map(() => 
                    new Array(targetSum + 1).fill(0).map(() => 
                        new Array(2).fill(0).map(() => 
                            new Array(2).fill(-1) // -1 indicates not computed yet
                        )
                    )
                )
            );

            // dp function counts numbers <= n_str such that sum_of_digits(x) == targetSum and x % targetSum == 0.
            // index: current digit position we are considering (from left to right)
            // currentRemainder: the remainder of the number formed so far when divided by targetSum
            // currentSum: the sum of digits placed so far
            // isLess: true if the number formed so far is already strictly less than the prefix of 's'
            // isStarted: true if we have placed at least one non-zero digit (to handle leading zeros)
            function dp(index, currentRemainder, currentSum, isLess, isStarted) {
                // Optimization: if currentSum already exceeds targetSum, this path cannot lead to a valid number.
                if (currentSum > targetSum) {
                    return 0;
                }

                // Base case: all digits have been processed.
                if (index === N) {
                    // A number is valid if:
                    // 1. It has been started (not composed entirely of leading zeros, i.e., not the number 0).
                    // 2. Its sum of digits exactly matches targetSum.
                    // 3. It is divisible by targetSum (currentRemainder is 0).
                    return (isStarted && currentSum === targetSum && currentRemainder === 0) ? 1 : 0;
                }

                // Check memoization table.
                if (memo[index][currentRemainder][currentSum][isLess][isStarted] !== -1) {
                    return memo[index][currentRemainder][currentSum][isLess][isStarted];
                }

                let res = 0;
                // Determine the upper bound for the current digit.
                // If isLess is true, we can place any digit from 0 to 9.
                // Otherwise, we can only place digits from 0 up to s[index].
                let upperBound = isLess ? 9 : parseInt(s[index]);

                for (let digit = 0; digit <= upperBound; digit++) {
                    if (!isStarted && digit === 0) {
                        // Handling leading zeros:
                        // If we are still placing leading zeros, currentRemainder and currentSum remain 0.
                        // isStarted remains false.
                        // isLess might become true if 'digit' (0) is less than 'upperBound' (s[index]).
                        res += dp(index + 1, 0, 0, isLess || (digit < upperBound), false);
                    } else {
                        // If a non-zero digit is placed or we are past leading zeros:
                        // Update remainder and sum. Set isStarted to true.
                        let newRemainder = (currentRemainder * 10 + digit) % targetSum;
                        let newSum = currentSum + digit;
                        res += dp(index + 1, newRemainder, newSum, isLess || (digit < upperBound), true);
                    }
                }

                // Store the result in the memoization table.
                memo[index][currentRemainder][currentSum][isLess][isStarted] = res;
                return res;
            }

            // Add the count for the current targetSum to the total.
            totalBeautiful += dp(0, 0, 0, false, false);
        }
        return totalBeautiful;
    }

    // The problem asks for beautiful numbers in the range [low, high].
    // This is typically solved by counting numbers up to high and subtracting
    // numbers up to (low - 1).
    return solve(high) - solve(low - 1);
};