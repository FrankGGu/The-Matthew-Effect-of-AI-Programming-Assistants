impl Solution {
    pub fn special_array(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable_by(|a, b| b.cmp(a));
        let n = nums.len();

        for x in 1..=n {
            if nums[x - 1] >= x as i32 {
                if x == n || nums[x] < x as i32 {
                    return x as i32;
                }
            }
        }

        -1
    }
}