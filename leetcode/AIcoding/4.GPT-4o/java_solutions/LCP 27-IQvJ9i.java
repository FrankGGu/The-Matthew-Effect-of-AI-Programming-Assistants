class Solution {
    public int mirrorReflection(int p, int q) {
        int gcd = gcd(p, q);
        int x = p / gcd;
        int y = q / gcd;

        if (x % 2 == 0) {
            return 2; // Reaches the right side
        } else if (y % 2 == 0) {
            return 0; // Reaches the left side
        } else {
            return 1; // Reaches the top
        }
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