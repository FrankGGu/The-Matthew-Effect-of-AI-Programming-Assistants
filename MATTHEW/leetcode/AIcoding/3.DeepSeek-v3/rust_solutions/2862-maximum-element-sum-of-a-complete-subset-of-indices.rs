impl Solution {
    pub fn maximum_sum(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut max_sum = 0i64;
        for i in 1..=n {
            let mut current_sum = 0i64;
            let mut j = 1;
            while j * j <= i {
                if i % j == 0 {
                    let k1 = j;
                    let k2 = i / j;
                    if k1 <= n {
                        current_sum += nums[k1 - 1] as i64;
                    }
                    if k2 != k1 && k2 <= n {
                        current_sum += nums[k2 - 1] as i64;
                    }
                }
                j += 1;
            }
            if current_sum > max_sum {
                max_sum = current_sum;
            }
        }
        max_sum
    }
}