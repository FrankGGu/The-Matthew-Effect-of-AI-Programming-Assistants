class Solution {
    public int findTheWinner(int n, int k) {
        return (findTheWinnerHelper(n, k) + 1);
    }

    private int findTheWinnerHelper(int n, int k) {
        if (n == 1) {
            return 0;
        }
        return (findTheWinnerHelper(n - 1, k) + k) % n;
    }
}