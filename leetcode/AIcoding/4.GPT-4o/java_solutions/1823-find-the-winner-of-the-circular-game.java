class Solution {
    public int findTheWinner(int n, int k) {
        return helper(n, k);
    }

    private int helper(int n, int k) {
        if (n == 1) {
            return 1;
        }
        return (helper(n - 1, k) + k - 1) % n + 1;
    }
}