impl Solution {
    pub fn maximize_greatness(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let mut res = 0;
        let mut i = 0;
        let mut j = 0;
        let n = nums.len();
        while j < n {
            if nums[j] > nums[i] {
                res += 1;
                i += 1;
            }
            j += 1;
        }
        res
    }
}