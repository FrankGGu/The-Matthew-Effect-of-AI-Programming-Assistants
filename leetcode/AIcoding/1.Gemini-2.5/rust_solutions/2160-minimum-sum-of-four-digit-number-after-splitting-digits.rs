impl Solution {
    pub fn minimum_sum(num: i32) -> i32 {
        let mut digits = Vec::with_capacity(4);
        let mut n = num;

        for _ in 0..4 {
            digits.push(n % 10);
            n /= 10;
        }

        digits.sort_unstable();

        // To minimize the sum of two 2-digit numbers (or 1-digit if leading zero),
        // the smallest digits should be in the tens places.
        // Let the sorted digits be d0, d1, d2, d3.
        // We form two numbers: (d0 * 10 + d2) and (d1 * 10 + d3).
        // Their sum is (d0 * 10 + d2) + (d1 * 10 + d3).
        (digits[0] * 10 + digits[2]) + (digits[1] * 10 + digits[3])
    }
}