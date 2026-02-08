int mirrorReflection(int p, int q) {
    int gcd = __gcd(p, q);
    int x = p / gcd;
    int y = q / gcd;

    if (y % 2 == 0) return 2;
    return (x % 2 == 0) ? 0 : 1;
}