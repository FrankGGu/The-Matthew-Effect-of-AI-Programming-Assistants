impl Solution {
    pub fn find_error_nums(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len() as i32;
        let mut duplicate = -1;
        let mut missing = -1;
        let mut seen = vec![false; nums.len() + 1];

        for &num in &nums {
            if seen[num as usize] {
                duplicate = num;
            } else {
                seen[num as usize] = true;
            }
        }

        for i in 1..=n {
            if !seen[i as usize] {
                missing = i;
                break;
            }
        }

        vec![duplicate, missing]
    }
}