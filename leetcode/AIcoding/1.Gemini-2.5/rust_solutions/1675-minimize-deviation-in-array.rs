use std::collections::BinaryHeap;
use std::cmp::min;

impl Solution {
    pub fn minimum_deviation(nums: Vec<i32>) -> i32 {
        let mut pq = BinaryHeap::new();
        let mut current_min = i32::MAX;

        for mut num in nums {
            // For an odd number, we must multiply it by 2 to make it even
            // and allow it to be divided later. This sets its initial maximum.
            // If we don't multiply, it stays odd and cannot be changed.
            // For an even number, its initial maximum is itself.
            if num % 2 == 1 {
                num *= 2;
            }
            current_min = min(current_min, num);
            pq.push(num);
        }

        let mut min_deviation = i32::MAX;

        loop {
            // The current maximum value in our set
            let max_val_in_heap = *pq.peek().unwrap();

            // Update the minimum deviation found so far
            min_deviation = min(min_deviation, max_val_in_heap - current_min);

            // If the current maximum value is odd, we cannot divide it further.
            // Since all other numbers can only be reduced (or stay the same),
            // we cannot improve the deviation by reducing any other number
            // while this odd maximum remains. So, we stop.
            if max_val_in_heap % 2 == 1 {
                break;
            }

            // If the maximum is even, we can reduce it by dividing by 2.
            let popped_max = pq.pop().unwrap();
            let new_val = popped_max / 2;

            // Update the overall minimum value in the set, as the new_val might be smaller.
            current_min = min(current_min, new_val);

            // Add the reduced value back to the heap.
            pq.push(new_val);
        }

        min_deviation
    }
}