impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_moves_to_pick_k_ones(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut ones = Vec::new();

        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                ones.push(i);
            }
        }

        if ones.len() < k {
            return -1;
        }

        let mut res = i32::MAX;
        let mut q = VecDeque::new();

        for i in 0..k {
            q.push_back(ones[i]);
        }

        let mut total = 0;
        for i in 0..k {
            total += ones[i] as i32;
        }

        res = total;

        for i in k..ones.len() {
            q.pop_front();
            q.push_back(ones[i]);

            let avg = (ones[i] as i32 + ones[i - k] as i32) / 2;
            let mut current = 0;
            for &pos in &q {
                current += (pos as i32 - avg).abs();
            }

            res = res.min(current);
        }

        res
    }
}
}