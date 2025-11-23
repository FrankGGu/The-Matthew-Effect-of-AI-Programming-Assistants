use std::collections::BTreeMap;

impl Solution {
    pub fn is_possible_divide(nums: Vec<i32>, k: i32) -> bool {
        let k = k as usize;
        if nums.len() % k != 0 {
            return false;
        }
        let mut count = BTreeMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }
        while let Some((&first, _)) = count.iter().next() {
            for num in first..first + k as i32 {
                if let Some(cnt) = count.get_mut(&num) {
                    *cnt -= 1;
                    if *cnt == 0 {
                        count.remove(&num);
                    }
                } else {
                    return false;
                }
            }
        }
        true
    }
}