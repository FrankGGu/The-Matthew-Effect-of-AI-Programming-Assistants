int maxNiceDivisors(int primeFactors) {
    if (primeFactors == 1) return 1;
    if (primeFactors == 2) return 2;
    if (primeFactors == 3) return 3;

    long long mod = 1000000007;
    long long result = 1;

    int quotient = primeFactors / 3;
    int remainder = primeFactors % 3;

    if (remainder == 1) {
        quotient--;
        remainder = 4;
    } else if (remainder == 0) {
        remainder = 1;
    }

    while (quotient > 0) {
        if (quotient % 2 == 1) {
            result = (result * 3) % mod;
        }
        quotient /= 2;
        if (quotient > 0) {
            long long base = 3;
            long long power = 1;
            int temp = quotient;
            while (temp > 0) {
                if (temp % 2 == 1) {
                    power = (power * base) % mod;
                }
                base = (base * base) % mod;
                temp /= 2;
            }
            result = (result * power) % mod;
            break;
        }
    }

    result = (result * remainder) % mod;
    return result;
}