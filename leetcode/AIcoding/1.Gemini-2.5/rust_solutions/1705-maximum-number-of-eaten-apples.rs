use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_eaten_apples(apples: Vec<i32>, days: Vec<i32>) -> i32 {
        let n = apples.len();
        let mut eaten_apples = 0;
        // Min-heap to store (expiration_day, count)
        // Using Reverse to make BinaryHeap act as a min-heap on the first element (expiration_day)
        let mut heap: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new();

        let mut day = 0;

        loop {
            // 1. Add new apples for the current day
            if day < n {
                if apples[day] > 0 {
                    // An apple picked on 'day' with 'days[day]' shelf life
                    // can be eaten up to 'day + days[day] - 1'.
                    // It expires on 'day + days[day]'.
                    heap.push(Reverse((day as i32 + days[day], apples[day])));
                }
            }

            // 2. Remove expired apples from the heap
            while let Some(&Reverse((expiration_day, _))) = heap.peek() {
                if expiration_day <= day as i32 {
                    heap.pop(); // Pop the expired apple
                } else {
                    break; // The top apple is not expired, so no other apples are expired either
                }
            }

            // 3. Eat an apple if available
            if let Some(mut apple_entry) = heap.pop() {
                apple_entry.0.1 -= 1; // Decrement count
                eaten_apples += 1;
                if apple_entry.0.1 > 0 {
                    heap.push(apple_entry); // If still apples left, push back
                }
            }

            // 4. Check termination condition
            // If there are no more new apples to pick and no apples left in the heap, we are done.
            day += 1;
            if day >= n && heap.is_empty() {
                break;
            }
        }

        eaten_apples
    }
}