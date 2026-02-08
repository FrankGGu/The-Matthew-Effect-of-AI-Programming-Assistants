impl Solution {
    pub fn triangle_type(nums: Vec<i32>) -> String {
        let mut nums = nums;
        nums.sort();
        let (a, b, c) = (nums[0], nums[1], nums[2]);
        if a + b <= c {
            return "Not A Triangle".to_string();
        }
        if a * a + b * b == c * c {
            "Right".to_string()
        } else if a * a + b * b > c * c {
            "Acute".to_string()
        } else {
            "Obtuse".to_string()
        }
    }
}