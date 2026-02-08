pub fn maximum_or(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    let mut max_or = 0;

    for i in 0..n {
        let mut current_or = nums[i];
        for j in 0..n {
            if i != j {
                current_or |= nums[j];
            }
        }
        max_or = max_or.max(current_or << k);
    }

    max_or
}