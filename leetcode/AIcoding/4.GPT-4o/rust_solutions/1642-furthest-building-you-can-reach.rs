use std::collections::BinaryHeap;

pub fn furthest_building(heights: Vec<i32>, bricks: i32, ladders: i32) -> i32 {
    let mut min_heap = BinaryHeap::new();
    let mut total_bricks = 0;

    for i in 0..heights.len() - 1 {
        let diff = heights[i + 1] - heights[i];
        if diff > 0 {
            min_heap.push(diff);
            if min_heap.len() > ladders as usize {
                total_bricks += min_heap.pop().unwrap();
            }
            if total_bricks > bricks {
                return i as i32;
            }
        }
    }

    (heights.len() - 1) as i32
}