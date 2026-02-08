use std::collections::BinaryHeap;

impl Solution {
    pub fn furthest_building(heights: Vec<i32>, bricks: i32, ladders: i32) -> i32 {
        let mut bricks = bricks;
        let mut ladder_heap = BinaryHeap::new();

        for i in 0..heights.len() - 1 {
            let diff = heights[i + 1] - heights[i];
            if diff <= 0 {
                continue;
            }

            ladder_heap.push(-diff);
            if ladder_heap.len() > ladders as usize {
                if let Some(smallest) = ladder_heap.pop() {
                    bricks += smallest;
                }
            }
            if bricks < 0 {
                return i as i32;
            }
        }

        (heights.len() - 1) as i32
    }
}