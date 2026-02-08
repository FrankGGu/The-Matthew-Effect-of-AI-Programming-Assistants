#include <stdbool.h>
#include <limits.h> // For LLONG_MAX

long long gcd(long long a, long long b) {
    while (b) {
        long long temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

long long safe_lcm(long long a, long long b) {
    // Calculate GCD first
    long long common_divisor = gcd(a, b);

    // To prevent overflow, divide 'a' by GCD before multiplying by 'b'.
    // Check if (a / common_divisor) * b would overflow LLONG_MAX.
    // This is equivalent to checking if b > LLONG_MAX / (a / common_divisor).
    long long val_a_divided = a / common_divisor;

    if (val_a_divided > LLONG_MAX / b) {
        // If multiplication would overflow, return LLONG_MAX to indicate an extremely large LCM.
        // For the purpose of 'x / LCM', an overflowed LCM means x / LCM will be 0
        // for any 'x' that fits within LLONG_MAX, which is the desired behavior.
        return LLONG_MAX; 
    }
    return val_a_divided * b;
}

bool check(long long x, int uniqueCnt1, int uniqueCnt2, int divisor1, int divisor2) {
    long long n1 = uniqueCnt1;
    long long n2 = uniqueCnt2;
    long long d1 = divisor1;
    long long d2 = divisor2;

    // Calculate LCM of divisor1 and divisor2
    long long common_lcm = safe_lcm(d1, d2);

    // Basic check: If the required count for an array is greater than the total
    // available multiples of its divisor up to 'x', it's impossible.
    if (n1 > x / d1 || n2 > x / d2) {
        return false;
    }

    // Total multiples of d1 up to x
    long long count1_all = x / d1;
    // Total multiples of d2 up to x
    long long count2_all = x / d2;
    // Total multiples of both d1 and d2 (i.e., multiples of LCM) up to x
    // If common_lcm is LLONG_MAX (due to overflow), x / common_lcm will be 0, which is correct.
    long long count_both_all = x / common_lcm;

    // Numbers that are multiples of d1 but NOT d2
    long long can_take_from_1_only = count1_all - count_both_all;
    // Numbers that are multiples of d2 but NOT d1
    long long can_take_from_2_only = count2_all - count_both_all;
    // Numbers that are multiples of both d1 and d2
    long long can_take_from_both = count_both_all;

    long long needed1 = n1;
    long long needed2 = n2;

    // Try to satisfy arr1's requirements using numbers only divisible by d1
    needed1 = (needed1 > can_take_from_1_only) ? (needed1 - can_take_from_1_only) : 0;

    // Try to satisfy arr2's requirements using numbers only divisible by d2
    needed2 = (needed2 > can_take_from_2_only) ? (needed2 - can_take_from_2_only) : 0;

    // If there are still elements needed for arr1 or arr2, they must come from
    // the numbers divisible by both d1 and d2 (common multiples).
    // Check if the total remaining needed elements can be satisfied by 'can_take_from_both'.
    return (needed1 + needed2 <= can_take_from_both);
}

int minimizeSet(int uniqueCnt1, int uniqueCnt2, int divisor1, int divisor2) {
    long long low = 1;
    // A sufficiently large upper bound for the binary search.
    // The maximum possible value for x could be around (uniqueCnt * divisor) for large inputs,
    // which can be up to 10^9 * 10^9 = 10^18. LLONG_MAX is ~9 * 10^18.
    // 2 * 10^18 is a safe practical upper bound.
    long long high = 2000000000000000000LL; 
    long long ans = high; // Initialize answer with the upper bound

    // Binary search for the minimum 'x' that satisfies the conditions
    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (check(mid, uniqueCnt1, uniqueCnt2, divisor1, divisor2)) {
            ans = mid;     // 'mid' is a possible answer, try for a smaller one
            high = mid - 1;
        } else {
            low = mid + 1; // 'mid' is too small, need a larger 'x'
        }
    }
    return (int)ans;
}