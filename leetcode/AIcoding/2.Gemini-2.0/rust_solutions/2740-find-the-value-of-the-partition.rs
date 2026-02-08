impl Solution {
    pub fn find_value_of_partition(nums: Vec<i32>) -> i32 {
        let mut nums_sorted = nums;
        nums_sorted.sort();
        let mut min_diff = i32::MAX;
        for i in 0..nums_sorted.len() - 1 {
            let diff = (nums_sorted[i+1] - nums_sorted[i]).abs();
            if diff < min_diff {
                min_diff = diff;
            }
        }
        min_diff
    }
}