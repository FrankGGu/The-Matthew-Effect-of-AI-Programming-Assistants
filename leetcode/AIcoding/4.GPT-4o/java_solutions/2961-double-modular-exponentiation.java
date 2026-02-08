class Solution {
    public int modExp(int a, int b, int m) {
        long res = 1;
        long x = a % m;
        while (b > 0) {
            if ((b & 1) == 1) {
                res = (res * x) % m;
            }
            x = (x * x) % m;
            b >>= 1;
        }
        return (int)(res % m);
    }

    public int doubleModExp(int a, int b, int c, int d, int m) {
        int firstExp = modExp(a, b, m);
        int secondExp = modExp(c, d, m);
        return (firstExp + secondExp) % m;
    }
}