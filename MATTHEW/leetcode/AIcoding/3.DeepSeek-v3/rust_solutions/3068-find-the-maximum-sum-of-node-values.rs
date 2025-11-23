impl Solution {
    pub fn maximum_value_sum(nums: Vec<i32>, k: i32, edges: Vec<Vec<i32>>) -> i64 {
        let mut total = 0i64;
        let mut count = 0;
        let mut min_diff = i32::MAX;

        for &num in &nums {
            let xor = num ^ k;
            if xor > num {
                total += xor as i64;
                count += 1;
                min_diff = min_diff.min(xor - num);
            } else {
                total += num as i64;
                min_diff = min_diff.min(num - xor);
            }
        }

        if count % 2 == 1 {
            total -= min_diff as i64;
        }

        total
    }
}