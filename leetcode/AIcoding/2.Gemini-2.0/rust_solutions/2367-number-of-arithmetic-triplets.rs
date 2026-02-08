impl Solution {
    pub fn arithmetic_triplets(nums: Vec<i32>, diff: i32) -> i32 {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            for j in (i + 1)..n {
                if nums[j] - nums[i] == diff {
                    for k in (j + 1)..n {
                        if nums[k] - nums[j] == diff {
                            count += 1;
                        }
                    }
                }
            }
        }
        count
    }
}