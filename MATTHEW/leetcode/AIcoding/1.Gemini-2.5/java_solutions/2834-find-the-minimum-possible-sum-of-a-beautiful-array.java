class Solution {
    public long minimumPossibleSum(int n, int target) {
        long totalSum = 0;
        long count = 0; // Number of elements picked so far

        // Phase 1: Pick numbers that are less than or equal to target / 2.
        // For each 'num' picked in this phase, 'target - num' is a larger number.
        // By picking 'num', we effectively prevent picking 'target - num', which is optimal
        // for minimizing the sum.
        long limit = target / 2; // The largest number to pick in this phase

        long currentNum = 1; // Start considering numbers from 1
        while (count < n && currentNum <= limit) {
            totalSum += currentNum;
            count++;
            currentNum++;
        }

        // Phase 2: If we still need to pick more numbers,
        // start picking from 'target' and onwards.
        // Numbers like target, target+1, target+2, etc. cannot form a sum of 'target'
        // with any number already picked (which are all <= target/2).
        // Also, these numbers themselves (target, target+1, ...) cannot form a sum of 'target'
        // with any other positive integer (e.g., target + x = target implies x = 0).
        long remainingCount = n - count;
        if (remainingCount > 0) {
            // We need to add 'remainingCount' numbers.
            // The first number to add is 'target'.
            // The last number to add will be 'target + remainingCount - 1'.
            // This is an arithmetic series sum: num_terms * (first_term + last_term) / 2
            long firstTerm = target;
            long lastTerm = target + remainingCount - 1;
            totalSum += remainingCount * (firstTerm + lastTerm) / 2;
        }

        return totalSum;
    }
}