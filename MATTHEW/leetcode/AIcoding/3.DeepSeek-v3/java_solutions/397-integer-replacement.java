class Solution {
    public int integerReplacement(int n) {
        return helper(n, 0);
    }

    private int helper(long n, int steps) {
        if (n == 1) {
            return steps;
        }
        if (n % 2 == 0) {
            return helper(n / 2, steps + 1);
        } else {
            return Math.min(helper(n + 1, steps + 1), helper(n - 1, steps + 1));
        }
    }
}