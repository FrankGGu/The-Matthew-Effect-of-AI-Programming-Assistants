pub fn destroy_targets(nums: Vec<i32>, target: i32) -> i32 {
    let mut count = 0;
    let mut destroyed = vec![false; nums.len()];

    for i in 0..nums.len() {
        if !destroyed[i] && nums[i] % target == 0 {
            count += 1;
            for j in i..nums.len() {
                if nums[j] % target == 0 {
                    destroyed[j] = true;
                }
            }
        }
    }

    count
}