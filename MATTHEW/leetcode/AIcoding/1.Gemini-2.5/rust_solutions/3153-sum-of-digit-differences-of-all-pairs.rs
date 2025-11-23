struct Solution;

impl Solution {
    pub fn sum_digit_differences(nums: Vec<i32>) -> i64 {
        let mut total_sum_diff: i64 = 0;

        // Iterate through digit positions.
        // For numbers up to 10^9 (maximum i32 value is 2*10^9, but problem states 10^9),
        // there are at most 10 digits (0-indexed: 0 for units place, up to 9 for billions place).
        // For example, 10^0 (units) to 10^9 (billions).
        for k in 0..10 {
            // counts[d] will store how many numbers have digit 'd' at the current position 'k'.
            let mut counts = [0; 10];

            // Calculate the divisor to extract the k-th digit.
            // 10^0 for units, 10^1 for tens, etc.
            let divisor = 10u32.pow(k as u32);

            // Populate counts for the current digit position 'k'.
            for &num in nums.iter() {
                let digit = ((num as u32) / divisor) % 10;
                counts[digit as usize] += 1;
            }

            // Calculate the sum of digit differences for this specific position 'k'.
            // For any two distinct digits 'a' and 'b' (where a < b),
            // the absolute difference is (b - a).
            // This difference occurs for every pair of numbers where one has digit 'a'
            // and the other has digit 'b' at this position.
            // The number of such pairs is counts[a] * counts[b].
            // We sum these contributions for all possible pairs of distinct digits (a, b).
            for a in 0..10 {
                for b in (a + 1)..10 {
                    total_sum_diff += (counts[a] as i64) * (counts[b] as i64) * ((b - a) as i64);
                }
            }
        }

        total_sum_diff
    }
}