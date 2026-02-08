use std::collections::BinaryHeap;

impl Solution {
    pub fn furthest_building(heights: Vec<i32>, mut bricks: i32, mut ladders: i32) -> i32 {
        let n = heights.len();
        let mut pq = BinaryHeap::new(); // Max-heap to store brick costs

        for i in 0..n - 1 {
            let diff = heights[i + 1] - heights[i];

            if diff <= 0 {
                continue;
            }

            pq.push(diff);
            bricks -= diff;

            if bricks < 0 {
                if ladders > 0 {
                    let largest_brick_cost = pq.pop().unwrap();
                    bricks += largest_brick_cost;
                    ladders -= 1;
                } else {
                    return i as i32;
                }
            }
        }

        (n - 1) as i32
    }
}