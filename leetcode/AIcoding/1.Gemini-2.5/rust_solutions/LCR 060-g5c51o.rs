use std::collections::HashMap;
use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn top_k_frequent(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut freq_map: HashMap<i32, i32> = HashMap::new();
        for num in nums {
            *freq_map.entry(num).or_insert(0) += 1;
        }

        // Use a min-heap to keep track of the k most frequent elements.
        // The heap will store (frequency, number).
        // Since BinaryHeap is a max-heap, we use Reverse(frequency) to simulate a min-heap
        // based on frequency.
        let mut min_heap: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new();

        for (&num, &freq) in freq_map.iter() {
            min_heap.push(Reverse((freq, num)));
            if min_heap.len() > k as usize {
                min_heap.pop();
            }
        }

        let mut result: Vec<i32> = Vec::with_capacity(k as usize);
        while let Some(Reverse((_freq, num))) = min_heap.pop() {
            result.push(num);
        }

        // The problem statement does not specify the order of output,
        // but often it's expected in descending frequency or ascending value.
        // Popping from a min-heap will give elements in increasing order of frequency.
        // If we want them in any order, this is fine. If we want descending frequency,
        // we might need to reverse the result or use a different approach.
        // LeetCode usually accepts any order for "top K".
        result.reverse(); // To get them in roughly descending order of frequency (or arbitrary if frequencies are same)
                          // or just to match common expectations, though not strictly required.
        result
    }
}