impl Solution {
    pub fn sum_of_floored_pairs(nums: Vec<i32>) -> i64 {
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut count = vec![0; max_num + 1];

        for &num in &nums {
            count[num as usize] += 1;
        }

        let mut prefix_sum = vec![0; max_num + 1];
        for i in 1..=max_num {
            prefix_sum[i] = prefix_sum[i - 1] + count[i];
        }

        let mut result = 0;
        for i in 1..=max_num {
            if count[i] > 0 {
                let pairs = count[i] as i64 * (prefix_sum[max_num / i] as i64);
                result += pairs;
            }
        }

        result
    }
}