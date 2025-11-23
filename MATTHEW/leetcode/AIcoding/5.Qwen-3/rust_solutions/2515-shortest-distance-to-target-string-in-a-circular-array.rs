pub fn closet_target(nums: Vec<i32>, target: i32, start: usize) -> i32 {
    let n = nums.len();
    let mut min_dist = n as i32;

    for i in 0..n {
        if nums[i] == target {
            let dist = (i as i32 - start as i32).abs().min((start as i32 - i as i32).abs());
            min_dist = min_dist.min(dist);
        }
    }

    min_dist
}