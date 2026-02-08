var rearrangeSticks = function(n, k) {
    const MOD = 10**9 + 7;

    // dp[i][j] will store the number of ways to arrange i sticks such that j sticks are visible.
    // i: represents the number of sticks (from 1 to n)
    // j: represents the number of visible sticks (from 1 to k)

    // Initialize dp table with (n+1) rows and (k+1) columns, filled with zeros.
    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(0));

    // Base case: With 0 sticks, there is 1 way to have 0 visible sticks (an empty arrangement).
    // This base case is crucial for the calculation of dp[1][1].
    dp[0][0] = 1;

    // Iterate through the number of sticks from 1 up to n.
    for (let i = 1; i <= n; i++) {
        // Iterate through the number of visible sticks from 1 up to k.
        // The number of visible sticks (j) cannot exceed the total number of sticks (i).
        for (let j = 1; j <= i && j <= k; j++) {
            // Recurrence relation:
            // To arrange 'i' sticks with 'j' visible sticks:

            // Case 1: The shortest stick (stick 1) is placed at the very first position.
            //         If stick 1 is first, it is always visible.
            //         We then need to arrange the remaining (i-1) sticks (sticks 2 to i)
            //         to have (j-1) visible sticks.
            //         This is equivalent to dp[i-1][j-1] ways (by re-labeling sticks 2..i as 1..i-1).

            // Case 2: The shortest stick (stick 1) is NOT placed at the very first position.
            //         This means stick 1 must be hidden behind one of the taller sticks.
            //         First, arrange the (i-1) taller sticks (sticks 2 to i) to have 'j' visible sticks.
            //         This gives dp[i-1][j] ways (again, by re-labeling sticks 2..i as 1..i-1).
            //         Now, we have an arrangement of (i-1) sticks. We need to insert stick 1.
            //         To keep stick 1 hidden, it must be placed after any of the existing (i-1) sticks.
            //         There are (i-1) such positions where stick 1 can be inserted without becoming visible.
            //         This contributes (i-1) * dp[i-1][j] ways.

            dp[i][j] = (dp[i-1][j-1] + (i - 1) * dp[i-1][j]) % MOD;
        }
    }

    // The final result is the number of ways to arrange 'n' sticks with 'k' visible sticks.
    return dp[n][k];
};