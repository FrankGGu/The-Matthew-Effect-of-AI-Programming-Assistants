use std::collections::BTreeSet;

impl Solution {
    pub fn sum_of_imbalance_numbers(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut total_imbalance_sum: i64 = 0;

        for i in 0..n {
            let mut distinct_elements = BTreeSet::new();
            let mut current_imbalance: i64 = 0;

            for j in i..n {
                let current_val = nums[j];

                if distinct_elements.contains(&current_val) {
                    total_imbalance_sum += current_imbalance;
                    continue;
                }

                let mut prev_val: Option<i32> = None;
                let mut succ_val: Option<i32> = None;

                if let Some(&p) = distinct_elements.range(..current_val).rev().next() {
                    prev_val = Some(p);
                }
                if let Some(&s) = distinct_elements.range(current_val..).next() {
                    succ_val = Some(s);
                }

                match (prev_val, succ_val) {
                    (Some(p), Some(s)) => {
                        if s - p > 1 {
                            current_imbalance -= 1;
                        }
                        if current_val - p > 1 {
                            current_imbalance += 1;
                        }
                        if s - current_val > 1 {
                            current_imbalance += 1;
                        }
                    },
                    (Some(p), None) => {
                        if current_val - p > 1 {
                            current_imbalance += 1;
                        }
                    },
                    (None, Some(s)) => {
                        if s - current_val > 1 {
                            current_imbalance += 1;
                        }
                    },
                    (None, None) => {
                        // current_val is the first element, imbalance remains 0
                    }
                }

                distinct_elements.insert(current_val);

                total_imbalance_sum += current_imbalance;
            }
        }
        total_imbalance_sum
    }
}