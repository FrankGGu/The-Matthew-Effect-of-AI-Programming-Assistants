class Solution {
    public int minDays(int n) {
        if (n == 0) return 0;
        return 1 + Math.min(n % 2 + minDays(n / 2), n % 3 + minDays(n / 3));
    }
}