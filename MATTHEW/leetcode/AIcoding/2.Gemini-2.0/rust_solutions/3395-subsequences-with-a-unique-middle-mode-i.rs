impl Solution {
    pub fn number_of_subsequences(n: i32, nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        for i in 0..n {
            for j in i..n {
                let mut sub = Vec::new();
                for k in i..=j {
                    sub.push(nums[k]);
                }
                if Self::is_unique_middle_mode(&sub) {
                    count += 1;
                }
            }
        }
        count
    }

    fn is_unique_middle_mode(nums: &Vec<i32>) -> bool {
        if nums.is_empty() {
            return false;
        }
        let mut counts = std::collections::HashMap::new();
        for &num in nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut max_count = 0;
        let mut mode = -1;
        let mut unique = true;

        for (&num, &count) in &counts {
            if count > max_count {
                max_count = count;
                mode = num;
                unique = true;
            } else if count == max_count {
                unique = false;
            }
        }

        if !unique {
            return false;
        }

        if nums.len() % 2 == 1 {
            if nums[nums.len() / 2] == mode {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
}