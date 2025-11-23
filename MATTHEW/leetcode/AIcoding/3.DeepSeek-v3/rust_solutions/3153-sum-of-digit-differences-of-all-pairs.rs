impl Solution {
    pub fn sum_digit_differences(nums: Vec<i32>) -> i64 {
        let mut total = 0;
        let mut digit_counts = vec![vec![0; 10]; 10];

        for &num in &nums {
            let mut n = num;
            for d in 0..10 {
                let digit = (n % 10) as usize;
                digit_counts[d][digit] += 1;
                n /= 10;
            }
        }

        for d in 0..10 {
            for digit in 0..10 {
                let count = digit_counts[d][digit] as i64;
                total += count * (nums.len() as i64 - count);
            }
        }

        total / 2
    }
}