impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn remove_boxes(boxes: Vec<i32>) -> i32 {
        let n = boxes.len();
        let mut memo = HashMap::new();
        Self::dfs(&boxes, 0, n - 1, 0, &mut memo)
    }

    fn dfs(boxes: &[i32], left: usize, right: usize, k: usize, memo: &mut HashMap<(usize, usize, usize), i32>) -> i32 {
        if left > right {
            return 0;
        }
        if let Some(&val) = memo.get(&(left, right, k)) {
            return val;
        }

        let mut res = Self::dfs(boxes, left + 1, right, 0, memo);
        for i in left + 1..=right {
            if boxes[i] == boxes[left] {
                let temp = Self::dfs(boxes, left + 1, i - 1, k + 1, memo);
                let score = Self::dfs(boxes, i + 1, right, 0, memo);
                res = res.max(temp + score);
            }
        }

        memo.insert((left, right, k), res);
        res
    }
}
}