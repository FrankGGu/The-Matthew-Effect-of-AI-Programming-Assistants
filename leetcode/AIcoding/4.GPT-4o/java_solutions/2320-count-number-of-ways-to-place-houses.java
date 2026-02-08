class Solution {
    public int countHousePlacements(int n) {
        long mod = 1000000007;
        long a = 1, b = 1;
        for (int i = 0; i < n; i++) {
            long temp = (a + b) % mod;
            a = b;
            b = temp;
        }
        return (int)((b * b) % mod);
    }
}