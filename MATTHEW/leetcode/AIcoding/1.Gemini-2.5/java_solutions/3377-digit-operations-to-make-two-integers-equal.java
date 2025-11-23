import java.util.Arrays;

class Solution {
    long num1_val, num2_val, cost1_val, cost2_val;
    long[][] memo;
    long[] powersOf10;
    final long INF = Long.MAX_VALUE / 2; // Use half to prevent overflow when adding costs

    public long minCost(long num1, long num2, long cost1, long cost2) {
        this.num1_val = num1;
        this.num2_val = num2;
        this.cost1_val = cost1;
        this.cost2_val = cost2;

        // Numbers can be up to 10^18, which has 19 digits (0-18).
        // We need to process up to index 18, and index 19 for the final carry check.
        // The 'carry' can range from -2 to 2. We map this to array indices 0-4.
        memo = new long[20][5]; 
        for (int i = 0; i < 20; ++i) {
            Arrays.fill(memo[i], -1);
        }

        powersOf10 = new long[20];
        powersOf10[0] = 1;
        for (int i = 1; i < 20; ++i) {
            powersOf10[i] = powersOf10[i-1] * 10;
        }

        // Start the recursive process from the units digit (idx 0) with no initial carry (carry 0).
        return solve(0, 0);
    }

    private long solve(int idx, int carry) {
        // Base case: If we have processed all relevant digit positions (up to 18 for 10^18).
        // idx == 19 means we are considering the position beyond the most significant digit.
        if (idx == 19) {
            // If there's no remaining carry, the cost is 0. Otherwise, it's impossible.
            return carry == 0 ? 0 : INF;
        }

        // Memoization check
        if (memo[idx][carry + 2] != -1) {
            return memo[idx][carry + 2];
        }

        // Get the current digits of num1 and num2 at position 'idx'.
        long d1 = (num1_val / powersOf10[idx]) % 10;
        long d2 = (num2_val / powersOf10[idx]) % 10;

        // Calculate the 'remaining needed' difference at this digit position.
        // This is d2 - (d1 + carry from the previous digit).
        long rem_needed = d2 - (d1 + carry);

        long min_cost = INF;

        // Iterate over possible values for k2 (number of cost2 operations).
        // A cost2 operation changes the current digit by 10, effectively propagating a carry of 1 to the next digit.
        // So, k2 represents both the number of cost2 operations AND the carry propagated to the next digit (idx + 1).
        // The range of k2 is limited because 'rem_needed' is small (between -11 and 11).
        // If rem_needed is 11, k2 could be 1 (k1=1), 0 (k1=11), or 2 (k1=-9).
        // If rem_needed is -11, k2 could be -1 (k1=-1), 0 (k1=-11), or -2 (k1=9).
        // So, k2 (the next carry) will always be in the range [-2, 2].
        for (int k2 = -2; k2 <= 2; ++k2) {
            // k1 is the number of cost1 operations needed to resolve the remaining difference
            // after accounting for k2 * 10 change from cost2 operations.
            // rem_needed = k1 (from cost1) + k2 * 10 (from cost2)
            // So, k1 = rem_needed - k2 * 10.
            long k1 = rem_needed - k2 * 10;

            // Calculate the cost for current digit operations:
            // abs(k1) * cost1_val for changing by 1s.
            // abs(k2) * cost2_val for changing by 10s (which is also the next carry).
            long current_ops_cost = Math.abs(k1) * cost1_val + Math.abs(k2) * cost2_val;

            // Add the cost from the recursive call for the next digit, passing k2 as the new carry.
            long total_cost = current_ops_cost + solve(idx + 1, k2);

            min_cost = Math.min(min_cost, total_cost);
        }

        // Store and return the minimum cost for this state.
        return memo[idx][carry + 2] = min_cost;
    }
}