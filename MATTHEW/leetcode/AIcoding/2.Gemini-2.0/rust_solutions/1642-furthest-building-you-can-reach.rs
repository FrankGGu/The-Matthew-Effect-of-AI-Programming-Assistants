use std::collections::BinaryHeap;

impl Solution {
    pub fn furthest_building(heights: Vec<i32>, bricks: i32, ladders: i32) -> i32 {
        let mut bricks_used = 0;
        let mut ladder_allocations = BinaryHeap::new();

        for i in 0..heights.len() - 1 {
            let diff = heights[i + 1] - heights[i];
            if diff > 0 {
                bricks_used += diff;
                ladder_allocations.push(diff);

                if bricks_used > bricks {
                    if ladders > 0 {
                        if let Some(largest_climb) = ladder_allocations.pop() {
                            bricks_used -= largest_climb;
                        }
                    } else {
                        return i as i32;
                    }
                }
            }
        }

        (heights.len() - 1) as i32
    }
}