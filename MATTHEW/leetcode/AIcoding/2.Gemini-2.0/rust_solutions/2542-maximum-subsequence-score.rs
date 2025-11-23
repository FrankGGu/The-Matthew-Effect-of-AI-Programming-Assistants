use std::collections::BinaryHeap;

impl Solution {
    pub fn max_score(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let mut pairs: Vec<(i32, i32)> = nums1.iter().zip(nums2.iter()).map(|(&x, &y)| (x, y)).collect();
        pairs.sort_by(|a, b| b.1.cmp(&a.1));

        let mut heap = BinaryHeap::new();
        let mut sum: i64 = 0;
        let mut ans: i64 = 0;

        for i in 0..nums1.len() {
            let (n1, n2) = pairs[i];
            sum += n1 as i64;
            heap.push(n1);

            if heap.len() > k {
                sum -= heap.pop().unwrap() as i64;
            }

            if heap.len() == k {
                ans = ans.max(sum * n2 as i64);
            }
        }

        ans
    }
}