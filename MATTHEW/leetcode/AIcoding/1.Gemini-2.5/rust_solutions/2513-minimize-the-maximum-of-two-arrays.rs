struct Solution;

impl Solution {
    fn gcd(a: u64, b: u64) -> u64 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    fn lcm(a: u64, b: u64) -> u64 {
        // Divisors are guaranteed to be >= 1, so a and b are never 0.
        // Calculate LCM as (a / gcd(a, b)) * b to prevent overflow if a * b is too large.
        // The result can be up to 10^18, which fits in u64.
        (a / Self::gcd(a, b)) * b
    }

    fn check(x: u64, cnt1: u64, cnt2: u64, divisor1: u64, divisor2: u64) -> bool {
        let l = Self::lcm(divisor1, divisor2);

        // Count of numbers from 1 to x that are divisible by divisor1 but NOT by divisor2.
        // These numbers can only be used by arr1 (as they are divisible by divisor1, so arr2 cannot use them,
        // but they are not divisible by divisor2, so arr1 can use them).
        let can_only_1 = (x / divisor1).saturating_sub(x / l);

        // Count of numbers from 1 to x that are divisible by divisor2 but NOT by divisor1.
        // These numbers can only be used by arr2.
        let can_only_2 = (x / divisor2).saturating_sub(x / l);

        // Count of numbers from 1 to x that are NOT divisible by divisor1 AND NOT divisible by divisor2.
        // These numbers can be used by either arr1 or arr2.
        let can_both = x.saturating_sub(x / divisor1).saturating_sub(x / divisor2).saturating_add(x / l);

        let mut c1_needed = cnt1;
        let mut c2_needed = cnt2;

        // Fulfill arr1's needs using numbers only it can use
        let taken1_from_only_1 = c1_needed.min(can_only_1);
        c1_needed = c1_needed.saturating_sub(taken1_from_only_1);

        // Fulfill arr2's needs using numbers only it can use
        let taken2_from_only_2 = c2_needed.min(can_only_2);
        c2_needed = c2_needed.saturating_sub(taken2_from_only_2);

        // Check if remaining needs for both arrays can be met by common numbers.
        // The total remaining numbers needed must be less than or equal to the count of common numbers.
        c1_needed.saturating_add(c2_needed) <= can_both
    }

    pub fn minimize_set(cnt1: i32, cnt2: i32, divisor1: i32, divisor2: i32) -> i32 {
        let cnt1_u = cnt1 as u64;
        let cnt2_u = cnt2 as u64;
        let divisor1_u = divisor1 as u64;
        let divisor2_u = divisor2 as u64;

        let mut low: u64 = 1;
        // A safe upper bound for the binary search.
        // In the worst case (e.g., divisor1=2, divisor2=3), we might need about 3 times
        // the total count of numbers (cnt1 + cnt2).
        // Max (cnt1 + cnt2) is 2 * 10^9. So 3 * 2 * 10^9 = 6 * 10^9.
        // Using 10^10 to be very safe, which fits comfortably in u64.
        let mut high: u64 = 10_000_000_000; 
        let mut ans: u64 = high; // Initialize with a value that is certainly valid or too high

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, cnt1_u, cnt2_u, divisor1_u, divisor2_u) {
                ans = mid;
                // Try to find a smaller maximum value
                if mid == 0 { // Avoid mid-1 underflow if mid is 0 (though low starts at 1)
                    break;
                }
                high = mid - 1;
            } else {
                // Need a larger maximum value
                low = mid + 1;
            }
        }

        ans as i32
    }
}