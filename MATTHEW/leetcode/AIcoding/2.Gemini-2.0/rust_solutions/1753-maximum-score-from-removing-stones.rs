use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_score(a: i32, b: i32, c: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        heap.push(a);
        heap.push(b);
        heap.push(c);

        let mut score = 0;
        while heap.len() > 1 {
            let x = heap.pop().unwrap();
            let y = heap.pop().unwrap();
            score += 1;

            let new_x = x - 1;
            let new_y = y - 1;

            if new_x > 0 {
                heap.push(new_x);
            }
            if new_y > 0 {
                heap.push(new_y);
            }
        }

        score
    }
}