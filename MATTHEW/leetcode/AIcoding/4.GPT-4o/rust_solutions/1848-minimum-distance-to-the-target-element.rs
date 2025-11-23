pub fn get_min_distance(nums: Vec<i32>, target: i32, start: i32) -> i32 {
    let mut min_distance = i32::MAX;
    for (i, &num) in nums.iter().enumerate() {
        if num == target {
            min_distance = min_distance.min((i as i32 - start).abs());
        }
    }
    min_distance
}