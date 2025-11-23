impl Solution {
    pub fn max_score(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i32 {
        let n = nums1.len();
        let mut pairs: Vec<(i32, i32)> = nums1.iter().zip(nums2.iter()).map(|(&x, &y)| (x, y)).collect();
        pairs.sort_unstable_by(|a, b| b.1.cmp(&a.1));

        let mut max_score = 0;
        let mut total = 0;
        let mut min_heap = std::collections::BinaryHeap::new();

        for i in 0..k as usize {
            total += pairs[i].0;
            min_heap.push(pairs[i].0);
        }
        max_score = total * pairs[k as usize - 1].1;

        for i in k as usize..n {
            total += pairs[i].0;
            min_heap.push(pairs[i].0);
            total -= min_heap.pop().unwrap();
            max_score = max_score.max(total * pairs[i].1);
        }

        max_score
    }
}