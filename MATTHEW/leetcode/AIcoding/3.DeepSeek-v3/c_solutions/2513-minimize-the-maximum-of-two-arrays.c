int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

long long lcm(long long a, long long b) {
    return a / gcd(a, b) * b;
}

int minimizeSet(int divisor1, int divisor2, int uniqueCnt1, int uniqueCnt2) {
    long long left = 1, right = 1e15;
    long long lcm_val = lcm(divisor1, divisor2);

    while (left < right) {
        long long mid = left + (right - left) / 2;

        long long not_div1 = mid - mid / divisor1;
        long long not_div2 = mid - mid / divisor2;
        long long not_div_both = mid - mid / lcm_val;

        if (not_div1 >= uniqueCnt1 && 
            not_div2 >= uniqueCnt2 && 
            not_div_both >= uniqueCnt1 + uniqueCnt2) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}