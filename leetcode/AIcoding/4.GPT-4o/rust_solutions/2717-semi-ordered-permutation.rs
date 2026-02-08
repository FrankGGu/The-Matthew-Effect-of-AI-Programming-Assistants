impl Solution {
    pub fn semi_ordered_permutation(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut first = 0;
        let mut last = 0;

        for i in 0..n {
            if nums[i] == 1 {
                first = i;
            }
            if nums[i] == n as i32 {
                last = i;
            }
        }

        let mut result = 0;
        if first < last {
            result = (first + n - 2 - last) as i32;
        } else {
            result = (first + n - 1 - last) as i32;
        }

        result + 1
    }
}