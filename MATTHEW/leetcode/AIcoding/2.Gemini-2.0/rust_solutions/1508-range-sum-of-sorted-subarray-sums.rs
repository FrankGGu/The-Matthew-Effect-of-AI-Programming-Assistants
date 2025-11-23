impl Solution {
    pub fn range_sum(nums: Vec<i32>, n: i32, left: i32, right: i32) -> i32 {
        let mut sub_sums: Vec<i32> = Vec::new();
        for i in 0..nums.len() {
            let mut current_sum = 0;
            for j in i..nums.len() {
                current_sum += nums[j];
                sub_sums.push(current_sum);
            }
        }
        sub_sums.sort();
        let mut sum: i64 = 0;
        for i in (left - 1) as usize..(right as usize) {
            sum = (sum + sub_sums[i] as i64) % 1000000007;
        }
        sum as i32
    }
}