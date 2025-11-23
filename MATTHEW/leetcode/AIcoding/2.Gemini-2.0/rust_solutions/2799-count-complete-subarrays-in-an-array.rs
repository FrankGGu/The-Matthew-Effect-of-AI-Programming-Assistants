impl Solution {
    pub fn count_complete_subarrays(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let distinct_count = nums.iter().collect::<std::collections::HashSet<_>>().len();
        let mut count = 0;
        for i in 0..n {
            for j in i..n {
                let sub_array = &nums[i..=j];
                let sub_distinct_count = sub_array.iter().collect::<std::collections::HashSet<_>>().len();
                if sub_distinct_count == distinct_count {
                    count += 1;
                }
            }
        }
        count
    }
}