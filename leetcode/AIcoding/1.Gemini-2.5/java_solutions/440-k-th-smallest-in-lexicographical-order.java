class Solution {
    public int findKthNumber(int n, int k) {
        int curr = 1;
        k--; // Adjust k to be 0-indexed for easier comparison with counts

        while (k > 0) {
            long steps = countSteps(n, curr);
            if (k >= steps) {
                k -= steps;
                curr++;
            } else {
                curr *= 10;
                k--; // Moving to the child itself consumes one step
            }
        }

        return curr;
    }

    // Counts how many numbers from 1 to n start with the given prefix
    private long countSteps(int n, int prefix) {
        long count = 0;
        long currPrefix = prefix;
        long nextPrefix = prefix + 1;

        while (currPrefix <= n) {
            count += Math.min((long)n + 1, nextPrefix) - currPrefix;
            currPrefix *= 10;
            nextPrefix *= 10;
        }
        return count;
    }
}