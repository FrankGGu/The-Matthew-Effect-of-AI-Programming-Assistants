struct Solution;

impl Solution {
    pub fn closest_to_target(mut n: i32, mut target: i32) -> i32 {
        let mut result = n;
        let mut current = n;
        while current > 0 {
            result = std::cmp::min(result, (current - target).abs());
            current &= current - 1;
        }
        result
    }
}