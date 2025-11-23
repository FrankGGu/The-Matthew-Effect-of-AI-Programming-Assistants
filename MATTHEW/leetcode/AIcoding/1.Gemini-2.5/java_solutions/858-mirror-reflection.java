class Solution {
    public int mirrorReflection(int p, int q) {
        int commonDivisor = gcd(p, q);
        int kh = p / commonDivisor;
        int kv = q / commonDivisor;

        if (kh % 2 == 1) { // Ray reaches x = p wall
            if (kv % 2 == 1) { // Ray reaches y = p wall
                return 1; // Receiver 1 at (p, p)
            } else { // Ray reaches y = 0 wall
                return 0; // Receiver 0 at (p, 0)
            }
        } else { // Ray reaches x = 0 wall
            // Since kh and kv are coprime (p/g and q/g), they cannot both be even.
            // If kh is even, then kv must be odd.
            return 2; // Receiver 2 at (0, p)
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