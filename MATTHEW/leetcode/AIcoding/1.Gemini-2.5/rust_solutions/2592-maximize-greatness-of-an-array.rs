impl Solution {
    pub fn maximize_greatness(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let n = nums.len();
        let mut i = 0;
        let mut j = 0;
        let mut greatness = 0;

        while j < n {
            if nums[i] < nums[j] {
                greatness += 1;
                i += 1;
                j += 1;
            } else {
                j += 1;
            }
        }
        greatness
    }
}