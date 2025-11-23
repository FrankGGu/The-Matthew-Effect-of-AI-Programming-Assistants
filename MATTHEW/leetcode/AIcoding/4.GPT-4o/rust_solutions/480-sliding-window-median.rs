use std::collections::BinaryHeap;

struct SlidingWindowMedian {
    min_heap: BinaryHeap<i32>,
    max_heap: BinaryHeap<i32>,
}

impl SlidingWindowMedian {
    fn new() -> Self {
        Self {
            min_heap: BinaryHeap::new(),
            max_heap: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        self.max_heap.push(-num);
        self.min_heap.push(-self.max_heap.pop().unwrap());

        if self.min_heap.len() > self.max_heap.len() {
            self.max_heap.push(-self.min_heap.pop().unwrap());
        }
    }

    fn find_median(&self) -> f64 {
        if self.min_heap.len() == self.max_heap.len() {
            return (self.min_heap.peek().unwrap() as f64 + -self.max_heap.peek().unwrap() as f64) / 2.0;
        }
        -self.max_heap.peek().unwrap() as f64
    }
}

struct Solution;

impl Solution {
    pub fn median_sliding_window(nums: Vec<i32>, k: i32) -> Vec<f64> {
        let k = k as usize;
        let mut result = Vec::new();
        let mut window = SlidingWindowMedian::new();
        let mut count = std::collections::HashMap::new();

        for i in 0..nums.len() {
            window.add_num(nums[i]);
            *count.entry(nums[i]).or_insert(0) += 1;

            if i >= k - 1 {
                result.push(window.find_median());
                let out_num = nums[i - k + 1];
                count.entry(out_num).and_modify(|e| *e -= 1);
                if count[out_num] == 0 {
                    count.remove(&out_num);
                    // Rebuild the heaps
                    let mut new_window = SlidingWindowMedian::new();
                    for j in i - k + 2..=i {
                        new_window.add_num(nums[j]);
                    }
                    *window = new_window;
                }
            }
        }
        result
    }
}