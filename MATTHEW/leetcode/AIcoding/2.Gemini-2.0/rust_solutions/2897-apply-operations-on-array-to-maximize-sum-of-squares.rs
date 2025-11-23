impl Solution {
    pub fn maximum_sum_of_squares(nums: Vec<i32>) -> i64 {
        let mut counts = vec![0; 31];
        for num in &nums {
            for i in 0..31 {
                if (num >> i) & 1 == 1 {
                    counts[i] += 1;
                }
            }
        }

        let n = nums.len();
        let mut result = 0;
        for _ in 0..n {
            let mut num = 0;
            for i in 0..31 {
                if counts[i] > 0 {
                    num |= 1 << i;
                    counts[i] -= 1;
                }
            }
            result += (num as i64) * (num as i64);
        }

        result
    }
}