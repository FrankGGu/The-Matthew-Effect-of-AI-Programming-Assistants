class Solution {
    public String findTheWinner(int n, int k) {
        return String.valueOf(getWinner(n, k));
    }

    private int getWinner(int n, int k) {
        if (n == 1) return 1;
        return (getWinner(n - 1, k) + k - 1) % n + 1;
    }
}