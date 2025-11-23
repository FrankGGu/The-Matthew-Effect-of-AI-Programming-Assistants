impl Solution {
    pub fn k_length_apart(nums: Vec<i32>, k: i32) -> bool {
        let mut last_one_idx: Option<i32> = None;

        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                if let Some(prev_idx) = last_one_idx {
                    if (i as i32) - prev_idx < k + 1 {
                        return false;
                    }
                }
                last_one_idx = Some(i as i32);
            }
        }

        true
    }
}