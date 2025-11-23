use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn earliest_second_to_mark_indices(nums: Vec<i32>, operations: Vec<Vec<i32>>) -> i32 {
        let m = nums.len();
        let n = operations.len();

        let mut low = 1;
        let mut high = n as i32;
        let mut ans = -1;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(m, &nums, &operations, mid as usize) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn check(m: usize, nums: &[i32], operations: &[Vec<i32>], t: usize) -> bool {
        let total_nums_sum: i64 = nums.iter().map(|&x| x as i64).sum();

        let mut last_op_time: Vec<usize> = vec![0; m];
        for s in 1..=t {
            let op_idx = operations[s - 1][0] as usize - 1;
            last_op_time[op_idx] = s;
        }

        for i in 0..m {
            if last_op_time[i] == 0 {
                return false;
            }
        }

        let mut current_gain: i64 = 0;
        let mut pq: BinaryHeap<Reverse<i32>> = BinaryHeap::new(); // Min-heap of op_val

        for s in 1..=t {
            let op_idx = operations[s - 1][0] as usize - 1;
            let op_val = operations[s - 1][1];

            pq.push(Reverse(op_val));

            if last_op_time[op_idx] == s {
                if let Some(Reverse(_val_to_mark)) = pq.pop() {
                    // This operation's value is "consumed" for marking an index.
                    // It is not added to `current_gain`.
                } else {
                    // This case should not be reached if `last_op_time` check passed,
                    // as it implies an index cannot be marked at its last possible time.
                    return false;
                }
            }
        }

        while let Some(Reverse(val)) = pq.pop() {
            current_gain += val as i64;
        }

        current_gain >= total_nums_sum
    }
}