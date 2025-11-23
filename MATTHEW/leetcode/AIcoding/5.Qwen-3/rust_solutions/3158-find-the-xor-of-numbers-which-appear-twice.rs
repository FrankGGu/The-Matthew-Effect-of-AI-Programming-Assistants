struct Solution;

impl Solution {
    pub fn three_sum_multisets(nums: Vec<i32>, target: i32) -> i32 {
        let mut freq = std::collections::HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut result = 0;
        for (&a, &count_a) in &freq {
            if a * 3 == target {
                if count_a >= 3 {
                    result += count_a * (count_a - 1) * (count_a - 2) / 6;
                }
            } else if a * 2 < target {
                let b = target - a * 2;
                if let Some(&count_b) = freq.get(&b) {
                    if a != b {
                        result += count_a * count_a * count_b;
                    } else {
                        result += count_a * (count_a - 1) * count_b / 2;
                    }
                }
            }
        }

        result
    }
}