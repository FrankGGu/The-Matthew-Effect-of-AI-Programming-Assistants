impl Solution {
    pub fn number_of_good_splits(nums: Vec<i32>) -> i32 {
        let mut left = std::collections::HashMap::new();
        let mut right = std::collections::HashMap::new();

        for &num in &nums {
            *right.entry(num).or_insert(0) += 1;
        }

        let mut res = 0;
        for i in 0..nums.len() - 1 {
            let num = nums[i];
            *left.entry(num).or_insert(0) += 1;
            *right.entry(num).or_insert(0) -= 1;
            if right[&num] == 0 {
                right.remove(&num);
            }
            if left.len() == right.len() {
                res += 1;
            }
        }
        res
    }
}