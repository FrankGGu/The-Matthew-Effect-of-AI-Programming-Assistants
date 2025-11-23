impl Solution {
    pub fn subarrays_with_k_distinct(nums: Vec<i32>, k: i32) -> i32 {
        Solution::at_most_k_distinct(&nums, k) - Solution::at_most_k_distinct(&nums, k - 1)
    }

    fn at_most_k_distinct(nums: &Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut left = 0;
        let mut freq = std::collections::HashMap::new();
        let mut distinct = 0;

        for right in 0..nums.len() {
            let num = nums[right];
            if freq.get(&num).is_none() || freq[&num] == 0 {
                distinct += 1;
            }
            *freq.entry(num).or_insert(0) += 1;

            while distinct > k {
                let left_num = nums[left];
                *freq.entry(left_num).or_insert(0) -= 1;
                if freq[&left_num] == 0 {
                    distinct -= 1;
                }
                left += 1;
            }

            count += (right - left + 1) as i32;
        }

        count
    }
}