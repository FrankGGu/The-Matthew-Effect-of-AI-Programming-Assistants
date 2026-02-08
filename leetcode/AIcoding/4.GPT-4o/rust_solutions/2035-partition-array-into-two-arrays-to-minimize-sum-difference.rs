impl Solution {
    pub fn minimum_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len() / 2;
        let total: i32 = nums.iter().sum();
        let mut first_half = vec![];
        let mut second_half = vec![];

        for mask in 0..(1 << n) {
            let mut sum = 0;
            for j in 0..n {
                if mask & (1 << j) != 0 {
                    sum += nums[j];
                }
            }
            first_half.push(sum);
        }

        for mask in 0..(1 << n) {
            let mut sum = 0;
            for j in n..(2 * n) {
                if mask & (1 << (j - n)) != 0 {
                    sum += nums[j];
                }
            }
            second_half.push(sum);
        }

        first_half.sort();
        let half_sum = total / 2;
        let mut min_diff = i32::MAX;

        for sum1 in first_half.iter() {
            let target = half_sum - sum1;
            let pos = second_half.binary_search(&target).unwrap_or_else(|x| x);
            if pos < second_half.len() {
                min_diff = min_diff.min((total - 2 * (sum1 + second_half[pos])) as i32);
            }
            if pos > 0 {
                min_diff = min_diff.min((total - 2 * (sum1 + second_half[pos - 1])) as i32);
            }
        }

        min_diff
    }
}