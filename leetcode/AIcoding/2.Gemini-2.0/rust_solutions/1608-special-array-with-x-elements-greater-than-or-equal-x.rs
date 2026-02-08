impl Solution {
    pub fn special_array(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();

        for x in 1..=nums.len() as i32 {
            let mut count = 0;
            for &num in &nums {
                if num >= x {
                    count += 1;
                }
            }
            if count == x {
                return x;
            }
        }

        -1
    }
}