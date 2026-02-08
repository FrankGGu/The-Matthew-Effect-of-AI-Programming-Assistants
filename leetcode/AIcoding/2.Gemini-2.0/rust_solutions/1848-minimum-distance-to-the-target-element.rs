impl Solution {
    pub fn get_min_distance(nums: Vec<i32>, target: i32, start: i32) -> i32 {
        let mut min_dist = i32::MAX;
        for i in 0..nums.len() {
            if nums[i] == target {
                let dist = (i as i32 - start).abs();
                min_dist = min_dist.min(dist);
            }
        }
        min_dist
    }
}