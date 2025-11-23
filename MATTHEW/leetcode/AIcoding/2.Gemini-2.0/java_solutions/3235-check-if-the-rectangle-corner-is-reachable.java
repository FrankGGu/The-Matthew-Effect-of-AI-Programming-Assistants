class Solution {
    public boolean isRectangleCornerReachable(int width, int height, int x1, int y1, int x2, int y2) {
        return gcd(width, height) == 1;
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