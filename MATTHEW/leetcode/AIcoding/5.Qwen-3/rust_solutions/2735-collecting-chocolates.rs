impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn min_moves_to_collect_all_chocolates(mut choco: Vec<i32>, mut moves: Vec<Vec<i32>>) -> i32 {
        let n = choco.len();
        let mut heap = BinaryHeap::new();

        for i in 0..n {
            heap.push(Reverse((choco[i], i as i32)));
        }

        let mut res = 0;
        let mut pos = 0;

        while let Some(Reverse((val, idx))) = heap.pop() {
            if val == 0 {
                continue;
            }
            let dist = (idx - pos).abs();
            res += dist;
            pos = idx;
            for move_ in &mut moves {
                if move_[0] == idx {
                    move_[1] -= val;
                }
            }

            for move_ in &moves {
                if move_[1] > 0 {
                    let i = move_[0] as usize;
                    choco[i] -= move_[1];
                    if choco[i] > 0 {
                        heap.push(Reverse((choco[i], i as i32)));
                    }
                }
            }
        }

        res
    }
}
}