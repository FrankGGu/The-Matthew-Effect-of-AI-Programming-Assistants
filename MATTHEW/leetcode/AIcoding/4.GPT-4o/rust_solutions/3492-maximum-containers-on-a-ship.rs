impl Solution {
    pub fn max_containers(weights: Vec<i32>, max_weight: i32) -> i32 {
        let mut weights = weights;
        weights.sort_unstable();
        let mut count = 0;
        let mut left = 0;
        let mut right = weights.len() as i32 - 1;

        while left <= right {
            if weights[left as usize] + weights[right as usize] <= max_weight {
                count += 1;
                left += 1;
            }
            right -= 1;
        }

        count
    }
}