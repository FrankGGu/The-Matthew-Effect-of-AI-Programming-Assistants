class Solution {
    public boolean isReachable(int targetX, int targetY) {
        while (targetX % 2 == 0) {
            targetX /= 2;
        }
        while (targetY % 2 == 0) {
            targetY /= 2;
        }
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