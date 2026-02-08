use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn get_skyline(buildings: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut events = Vec::new();
        for building in &buildings {
            events.push((building[0], -building[2]));
            events.push((building[1], building[2]));
        }
        events.sort();

        let mut skyline = Vec::new();
        let mut heap = BinaryHeap::new();
        heap.push(0);
        let mut prev_height = 0;

        for (pos, height) in events {
            if height < 0 {
                heap.push(-height);
            } else {
                let mut temp_heap = BinaryHeap::new();
                while let Some(Reverse(h)) = heap.pop() {
                    if h != height {
                        temp_heap.push(Reverse(h));
                    } else {
                        break;
                    }
                }
                while let Some(Reverse(h)) = temp_heap.pop() {
                    heap.push(Reverse(h));
                }
            }

            let current_height = *heap.peek().unwrap();
            if current_height != prev_height {
                skyline.push(vec![pos, current_height]);
                prev_height = current_height;
            }
        }

        skyline
    }
}

struct Solution;