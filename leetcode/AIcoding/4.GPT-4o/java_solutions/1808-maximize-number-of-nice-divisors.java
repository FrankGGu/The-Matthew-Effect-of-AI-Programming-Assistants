class Solution {
    public int maxNiceDivisors(int n) {
        if (n <= 3) return n;
        long res = 1;
        while (n > 4) {
            res = (res * 3) % 1000000007;
            n -= 3;
        }
        return (int) (res * n % 1000000007);
    }
}