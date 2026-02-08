class Solution {
    public boolean isReachable(int targetX, int targetY) {
        return gcd(targetX, targetY) == 1;
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