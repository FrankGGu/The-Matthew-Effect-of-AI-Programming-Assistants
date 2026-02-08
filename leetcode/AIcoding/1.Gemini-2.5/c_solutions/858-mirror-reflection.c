int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int mirrorReflection(int p, int q) {
    int common_divisor = gcd(p, q);

    // k_x represents the number of horizontal room traversals
    // k_y represents the number of vertical room traversals
    // p/common_divisor and q/common_divisor are coprime.
    int k_x = p / common_divisor;
    int k_y = q / common_divisor;

    // k_x and k_y cannot both be even because they are coprime.
    // This leaves three possibilities for (k_x % 2, k_y % 2):
    // (1, 1), (1, 0), (0, 1)

    if (k_x % 2 == 1) { // The ray ends on the right wall (x=p)
        if (k_y % 2 == 1) { // The ray ends on the top wall (y=p)
            return 1; // Receiver 1 at (p,p)
        } else { // The ray ends on the bottom wall (y=0)
            return 0; // Receiver 0 at (p,0)
        }
    } else { // The ray ends on the left wall (x=0)
        // Since k_x is even, k_y must be odd (as they cannot both be even).
        // So, the ray ends on the top wall (y=p).
        return 2; // Receiver 2 at (0,p)
    }
}