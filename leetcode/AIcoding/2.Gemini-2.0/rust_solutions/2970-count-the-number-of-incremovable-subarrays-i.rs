impl Solution {
    pub fn incremovable_subarray_count(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        for i in 0..n {
            for j in i..n {
                let mut temp = Vec::new();
                for k in 0..n {
                    if k < i || k > j {
                        temp.push(nums[k]);
                    }
                }
                if temp.is_empty() || temp.windows(2).all(|w| w[0] < w[1]) {
                    count += 1;
                }
            }
        }
        count
    }
}