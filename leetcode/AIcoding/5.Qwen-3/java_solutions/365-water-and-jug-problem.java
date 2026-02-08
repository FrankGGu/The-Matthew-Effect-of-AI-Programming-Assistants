public class Solution {
    public boolean canMeasureWater(int x, int y, int z) {
        if (x + y < z) return false;
        if (x == 0 && y == 0) return z == 0;
        if (x == 0) return z % y == 0;
        if (y == 0) return z % x == 0;
        return z % gcd(x, y) == 0;
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