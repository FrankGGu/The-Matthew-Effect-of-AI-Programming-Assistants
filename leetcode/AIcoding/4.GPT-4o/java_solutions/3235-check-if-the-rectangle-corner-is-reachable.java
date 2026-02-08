class Solution {
    public boolean isReachable(int x, int y) {
        return gcd(Math.abs(x), Math.abs(y)) == 1;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}