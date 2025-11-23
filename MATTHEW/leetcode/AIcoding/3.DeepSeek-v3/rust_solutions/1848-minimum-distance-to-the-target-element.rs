impl Solution {
    pub fn get_min_distance(nums: Vec<i32>, target: i32, start: i32) -> i32 {
        let mut min_distance = std::i32::MAX;
        for (i, &num) in nums.iter().enumerate() {
            if num == target {
                let distance = (i as i32 - start).abs();
                if distance < min_distance {
                    min_distance = distance;
                }
            }
        }
        min_distance
    }
}