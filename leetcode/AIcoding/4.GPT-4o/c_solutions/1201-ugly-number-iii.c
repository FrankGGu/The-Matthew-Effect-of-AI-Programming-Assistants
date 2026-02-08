#include <stdbool.h>

bool isUgly(int num, int a, int b, int c) {
    if (num <= 0) return false;
    while (num % a == 0) num /= a;
    while (num % b == 0) num /= b;
    while (num % c == 0) num /= c;
    return num == 1;
}

int nthUglyNumber(int n, int a, int b, int c) {
    long lcm_ab = (long)a * b / __gcd(a, b);
    long lcm_ac = (long)a * c / __gcd(a, c);
    long lcm_bc = (long)b * c / __gcd(b, c);
    long lcm_abc = (long)lcm_ab * c / __gcd(lcm_ab, c);

    long left = 1, right = 2e9, answer = 0;

    while (left <= right) {
        long mid = left + (right - left) / 2;
        long count = mid / a + mid / b + mid / c - mid / lcm_ab - mid / lcm_ac - mid / lcm_bc + mid / lcm_abc;

        if (count >= n) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return answer;
}