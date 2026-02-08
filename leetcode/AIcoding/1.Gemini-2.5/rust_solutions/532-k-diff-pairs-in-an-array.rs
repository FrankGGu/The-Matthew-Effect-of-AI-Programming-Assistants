use std::collections::HashSet;
use std::collections::HashMap;

impl Solution {
    pub fn find_pairs(nums: Vec<i32>, k: i32) -> i32 {
        if k == 0 {
            let mut freq_map: HashMap<i32, i32> = HashMap::new();
            for num in nums {
                *freq_map.entry(num).or_insert(0) += 1;
            }

            let mut count = 0;
            for (_num, freq) in freq_map {
                if freq >= 2 {
                    count += 1;
                }
            }
            count
        } else { // k > 0
            let mut unique_nums: HashSet<i32> = HashSet::new();
            for num in nums {
                unique_nums.insert(num);
            }

            let mut count = 0;
            for num in &unique_nums {
                if unique_nums.contains(&(num + k)) {
                    count += 1;
                }
            }
            count
        }
    }
}