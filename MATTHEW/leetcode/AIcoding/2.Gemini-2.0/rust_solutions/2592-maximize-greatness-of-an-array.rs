impl Solution {
    pub fn maximize_greatness(nums: Vec<i32>) -> i32 {
        let mut sorted_nums = nums.clone();
        sorted_nums.sort();

        let mut count = 0;
        let mut j = 0;

        for i in 0..sorted_nums.len() {
            while j < sorted_nums.len() && sorted_nums[j] <= sorted_nums[i] {
                j += 1;
            }
            if j < sorted_nums.len() {
                count += 1;
                j += 1;
            }
        }

        count
    }
}