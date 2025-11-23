#include <algorithm> // For std::max
#include <utility>   // For std::swap

long long calculate_gcd(long long a, long long b) {
    while (b) {
        a %= b;
        std::swap(a, b);
    }
    return a;
}

long long calculate_lcm(long long a, long long b) {
    if (a == 0 || b == 0) return 0;
    // Use (a / gcd(a, b)) * b to prevent potential overflow if a * b is computed first.
    // Given constraints (a, b <= 10^9), a * b could be 10^18, which fits in long long.
    // However, this form is generally safer for larger inputs.
    return (a / calculate_gcd(a, b)) * b;
}

bool check(long long x, int div1, int div2, int cnt1, int cnt2) {
    // Convert inputs to long long for calculations to prevent overflow
    long long l_div1 = div1;
    long long l_div2 = div2;
    long long l_cnt1 = cnt1;
    long long l_cnt2 = cnt2;

    // Calculate numbers that are not divisible by div1 AND not divisible by div2.
    // These numbers can be placed in either arr1 or arr2.
    long long common_multiple = calculate_lcm(l_div1, l_div2);
    long long num_not_div1_and_not_div2 = x - (x / l_div1) - (x / l_div2) + (x / common_multiple);

    // Calculate numbers that are not divisible by div1, but ARE divisible by div2.
    // These numbers can ONLY go to arr1.
    // Count of numbers divisible by div2: x / l_div2
    // Count of numbers divisible by both div1 and div2: x / common_multiple
    // So, count of numbers div by div2 but NOT by div1 = (x / l_div2) - (x / common_multiple)
    long long only_for_arr1 = (x / l_div2) - (x / common_multiple);

    // Calculate numbers that are not divisible by div2, but ARE divisible by div1.
    // These numbers can ONLY go to arr2.
    // Count of numbers divisible by div1 but NOT by div2 = (x / l_div1) - (x / common_multiple)
    long long only_for_arr2 = (x / l_div1) - (x / common_multiple);

    // We need l_cnt1 elements for arr1 and l_cnt2 for arr2.
    // First, satisfy needs using numbers that can only go to one specific array.
    long long needed1 = l_cnt1;
    long long needed2 = l_cnt2;

    needed1 = std::max(0LL, needed1 - only_for_arr1);
    needed2 = std::max(0LL, needed2 - only_for_arr2);

    // Now, we need 'needed1' for arr1 and 'needed2' for arr2.
    // We have 'num_not_div1_and_not_div2' numbers that can go to either.
    // Check if we have enough of these common numbers to satisfy the remaining needs.
    return num_not_div1_and_not_div2 >= (needed1 + needed2);
}

class Solution {
public:
    long long minimizeTheMaximumOfTwoArrays(int div1, int div2, int cnt1, int cnt2) {
        long long low = 1;
        // The maximum possible value for 'x'.
        // In the worst case, if div1 and div2 are small (e.g., both 2),
        // roughly half the numbers up to 'x' are unusable for each array.
        // We might need 'x' to be approximately 2 * (cnt1 + cnt2).
        // Since cnt1, cnt2 can be up to 10^9, 2 * (10^9 + 10^9) = 4 * 10^9 is a safe upper bound.
        long long high = 4000000000LL; // 4 * 10^9
        long long ans = high; // Initialize answer with a large possible value

        // Perform binary search on the possible maximum value 'x'
        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (check(mid, div1, div2, cnt1, cnt2)) {
                ans = mid;         // 'mid' is a possible answer, try for a smaller one
                high = mid - 1;
            } else {
                low = mid + 1;     // 'mid' is not possible, need a larger 'x'
            }
        }
        return ans;
    }
};