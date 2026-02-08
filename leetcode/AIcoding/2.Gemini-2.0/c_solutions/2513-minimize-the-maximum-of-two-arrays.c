#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

long long lcm(long long a, long long b) {
    return (a * b) / gcd(a, b);
}

int minimizeSet(int divisor1, int divisor2, int uniqueCnt1, int uniqueCnt2) {
    int low = 1, high = 2e9;
    int ans = high;

    while (low <= high) {
        int mid = low + (high - low) / 2;

        int cnt1 = mid - mid / divisor1;
        int cnt2 = mid - mid / divisor2;
        int cnt_both = mid - mid / (lcm(divisor1, divisor2));

        if (cnt1 >= uniqueCnt1 && cnt2 >= uniqueCnt2 && cnt_both >= uniqueCnt1 + uniqueCnt2) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}