int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int mirrorReflection(int p, int q) {
    if (q == 0) {
        return 0;
    }

    int common_divisor = gcd(p, q);
    int p_prime = p / common_divisor;
    int q_prime = q / common_divisor;

    if (q_prime % 2 == 0) {
        return 2;
    } else {
        if (p_prime % 2 == 1) {
            return 1;
        } else {
            return 0;
        }
    }
}