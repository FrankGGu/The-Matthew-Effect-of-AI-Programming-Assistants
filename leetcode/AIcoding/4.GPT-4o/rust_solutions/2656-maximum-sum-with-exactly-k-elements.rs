impl Solution {
    pub fn max_sum(k: i32, m: i32, A: Vec<i32>) -> i32 {
        let mut max_sum = 0;
        let mut current_sum = 0;
        let mut min_heap = std::collections::BinaryHeap::new();

        for &num in A.iter() {
            min_heap.push(num);
            current_sum += num;
            if min_heap.len() > k as usize {
                current_sum -= min_heap.pop().unwrap();
            }
            if min_heap.len() == k as usize && current_sum % m == 0 {
                max_sum = max_sum.max(current_sum);
            }
        }
        max_sum
    }
}