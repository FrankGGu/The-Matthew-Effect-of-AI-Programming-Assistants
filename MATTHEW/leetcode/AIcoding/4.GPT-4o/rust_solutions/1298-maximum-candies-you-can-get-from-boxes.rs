use std::collections::BinaryHeap;

impl Solution {
    pub fn max_candies(boxes: Vec<Vec<i32>>, status: Vec<bool>) -> i32 {
        let n = boxes.len();
        let mut visited = vec![false; n];
        let mut max_candies = 0;
        let mut heap = BinaryHeap::new();

        for i in 0..n {
            if status[i] {
                heap.push((boxes[i][0], i));
                visited[i] = true;
            }
        }

        while let Some((candies, idx)) = heap.pop() {
            max_candies += candies;
            for &b in &boxes[idx][1..] {
                if !visited[b as usize] {
                    heap.push((boxes[b as usize][0], b as usize));
                    visited[b as usize] = true;
                }
            }
        }

        max_candies
    }
}