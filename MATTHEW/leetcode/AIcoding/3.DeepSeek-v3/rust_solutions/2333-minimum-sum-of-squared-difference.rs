impl Solution {
    pub fn min_sum_square_diff(nums1: Vec<i32>, nums2: Vec<i32>, k1: i32, k2: i32) -> i64 {
        let n = nums1.len();
        let mut diffs: Vec<i32> = nums1.iter().zip(nums2.iter()).map(|(&a, &b)| (a - b).abs()).collect();
        let mut k = (k1 + k2) as i64;

        let mut max_diff = *diffs.iter().max().unwrap_or(&0) as i64;
        let mut freq = vec![0; (max_diff + 1) as usize];
        for &diff in &diffs {
            freq[diff as usize] += 1;
        }

        let mut i = max_diff;
        while i > 0 && k > 0 {
            let count = freq[i as usize].min(k);
            freq[i as usize] -= count;
            freq[(i - 1) as usize] += count;
            k -= count;
            i -= 1;
        }

        let mut res = 0;
        for d in 0..=max_diff {
            res += (d * d) * freq[d as usize];
        }
        res
    }
}