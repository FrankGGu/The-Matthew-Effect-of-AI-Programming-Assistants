long long gcd(long long x, long long y) {
    while (y) {
        long long temp = y;
        y = x % y;
        x = temp;
    }
    return x;
}

const long long MAX_ANSWER_CAP = 2000000000LL + 7;

long long lcm(long long x, long long y) {
    if (x == 0 || y == 0) return 0;

    long long common_divisor = gcd(x, y);

    // Check for potential overflow before multiplication: (x / common_divisor) * y
    // If the result would exceed MAX_ANSWER_CAP, return MAX_ANSWER_CAP.
    // This is because if LCM is greater than MAX_ANSWER_CAP (which is > max possible 'num' in countUglyNumbers),
    // then 'num / LCM' will always be 0, effectively treating it as infinity.
    if (x / common_divisor > MAX_ANSWER_CAP / y) {
        return MAX_ANSWER_CAP;
    }
    return (x / common_divisor) * y;
}

long long countUglyNumbers(long long num, long long a, long long b, long long c) {
    long long count_a = num / a;
    long long count_b = num / b;
    long long count_c = num / c;

    long long lcm_ab = lcm(a, b);
    long long lcm_ac = lcm(a, c);
    long long lcm_bc = lcm(b, c);

    long long count_ab = num / lcm_ab;
    long long count_ac = num / lcm_ac;
    long long count_bc = num / lcm_bc;

    long long lcm_abc = lcm(lcm_ab, c);
    long long count_abc = num / lcm_abc;

    return count_a + count_b + count_c - count_ab - count_ac - count_bc + count_abc;
}

int nthUglyNumber(int n_int, int a_int, int b_int, int c_int) {
    long long n = n_int;
    long long a = a_int;
    long long b = b_int;
    long long c = c_int;

    long long low = 1;
    long long high = 2000000000LL; 
    long long ans = high; 

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (countUglyNumbers(mid, a, b, c) >= n) {
            ans = mid;
            high = mid - 1; 
        } else {
            low = mid + 1; 
        }
    }
    return (int)ans;
}