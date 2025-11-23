impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn number_of_longest_increasing_subsequence(mut nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let n = nums.len();
        let mut lengths = vec![1; n];
        let mut counts = vec![1; n];

        for i in 0..n {
            for j in 0..i {
                if nums[j] < nums[i] {
                    match lengths[j].cmp(&lengths[i]) {
                        Ordering::Less => {
                            lengths[i] = lengths[j] + 1;
                            counts[i] = counts[j];
                        }
                        Ordering::Equal => {
                            counts[i] += counts[j];
                        }
                        _ => {}
                    }
                }
            }
        }

        let max_length = *lengths.iter().max().unwrap();
        let mut result = 0;

        for i in 0..n {
            if lengths[i] == max_length {
                result += counts[i];
            }
        }

        result
    }
}
}