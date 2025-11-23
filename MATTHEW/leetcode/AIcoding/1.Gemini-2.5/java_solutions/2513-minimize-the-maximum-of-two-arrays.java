class Solution {

    private long gcd(long a, long b) {
        while (b != 0) {
            long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    private long lcm(long a, long b) {
        if (a == 0 || b == 0) return 0;
        if (a == 1 || b == 1) return Math.max(a, b); // Optimization for 1
        // To prevent potential overflow of a * b, divide first
        return (a / gcd(a, b)) * b;
    }

    private boolean check(long x, int uniqueCnt1, int uniqueCnt2, int divisor1, int divisor2) {
        // Count of numbers <= x that are not divisible by divisor1
        long count_not_div1 = x - (x / divisor1);

        // Count of numbers <= x that are not divisible by divisor2
        long count_not_div2 = x - (x / divisor2);

        // Calculate LCM of divisor1 and divisor2
        long common_multiple = lcm(divisor1, divisor2);

        // Count of numbers <= x that are not divisible by divisor1 AND not divisible by divisor2
        // Using inclusion-exclusion: x - (count(div by div1) + count(div by div2) - count(div by both))
        long count_not_div1_and_not_div2 = x - (x / divisor1 + x / divisor2 - (x / common_multiple));

        // Numbers that are not divisible by divisor1 but ARE divisible by divisor2.
        // These can only go to arr1 (since they satisfy arr1's condition but not arr2's).
        long available_for_arr1_only = count_not_div1 - count_not_div1_and_not_div2;

        // Numbers that are not divisible by divisor2 but ARE divisible by divisor1.
        // These can only go to arr2 (since they satisfy arr2's condition but not arr1's).
        long available_for_arr2_only = count_not_div2 - count_not_div1_and_not_div2;

        // Numbers that are not divisible by divisor1 AND not divisible by divisor2.
        // These can go to BOTH arr1 and arr2.
        long available_for_both = count_not_div1_and_not_div2;

        // Determine how many numbers are still needed for arr1 after using 'arr1_only' numbers
        long needed1_from_both = Math.max(0L, (long) uniqueCnt1 - available_for_arr1_only);

        // Determine how many numbers are still needed for arr2 after using 'arr2_only' numbers
        long needed2_from_both = Math.max(0L, (long) uniqueCnt2 - available_for_arr2_only);

        // Check if the 'available_for_both' pool can satisfy the remaining needs for both arrays
        return available_for_both >= (needed1_from_both + needed2_from_both);
    }

    public int minimizeTheMaximum(int uniqueCnt1, int uniqueCnt2, int divisor1, int divisor2) {
        long low = 1;
        // The maximum possible value for `x` could be around 2 * (uniqueCnt1 + uniqueCnt2)
        // For example, if divisor1=2, divisor2=2, and uniqueCnt1, uniqueCnt2 are 10^9.
        // We need 2 * 10^9 distinct odd numbers. The 2*10^9-th odd number is 2*(2*10^9) - 1 = 4*10^9 - 1.
        // So, 4 * 10^9 is a safe upper bound.
        long high = 4_000_000_000L; 
        long ans = high;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (check(mid, uniqueCnt1, uniqueCnt2, divisor1, divisor2)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return (int) ans;
    }
}