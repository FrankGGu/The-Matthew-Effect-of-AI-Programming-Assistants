impl Solution {
    pub fn k_sum(nums: Vec<i32>, k: i32) -> i64 {
        let mut positive_nums: Vec<i64> = nums.iter().map(|&x| x.abs() as i64).collect();
        let sum: i64 = positive_nums.iter().sum();
        positive_nums.sort_unstable();
        let mut heap: std::collections::BinaryHeap<(i64, usize)> = std::collections::BinaryHeap::new();
        heap.push((positive_nums[0], 0));
        let mut results: Vec<i64> = Vec::new();
        for _ in 0..k {
            let (val, idx) = heap.pop().unwrap();
            results.push(val);
            if idx < positive_nums.len() - 1 {
                heap.push((val + positive_nums[idx + 1], idx + 1));
                heap.push((val - positive_nums[idx] + positive_nums[idx + 1], idx + 1));
            }
        }
        sum - results[k as usize - 1]
    }
}