impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_adjacent_swaps(mut nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut positions = Vec::new();

        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                positions.push(i);
            }
        }

        let mut heap = BinaryHeap::new();
        for i in 0..positions.len() - k + 1 {
            let mut sum = 0;
            for j in 0..k {
                sum += (positions[i + j] as i64 - (i + j) as i64).abs();
            }
            heap.push((sum, i));
        }

        while let Some((_, i)) = heap.pop() {
            let mut res = 0;
            for j in 0..k {
                res += (positions[i + j] as i64 - (i + j) as i64).abs();
            }
            return res as i32;
        }

        0
    }
}
}