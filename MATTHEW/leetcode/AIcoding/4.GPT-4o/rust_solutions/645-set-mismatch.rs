impl Solution {
    pub fn find_error_nums(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len() as i32;
        let mut seen = vec![0; n as usize];
        let mut duplicate = -1;

        for &num in &nums {
            if seen[num as usize - 1] == 1 {
                duplicate = num;
            }
            seen[num as usize - 1] += 1;
        }

        let mut missing = -1;
        for i in 0..n {
            if seen[i as usize] == 0 {
                missing = i + 1;
                break;
            }
        }

        vec![duplicate, missing]
    }
}