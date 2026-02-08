impl Solution {
    pub fn count_inequalities(nums1: Vec<i32>, nums2: Vec<i32>, diff: i32) -> i32 {
        let n = nums1.len();
        let mut diffs: Vec<i32> = nums1.iter().zip(nums2.iter()).map(|(x, y)| x - y).collect();
        for d in diffs.iter_mut() {
            *d += diff;
        }
        diffs.sort();
        let mut count = 0;
        for i in 0..n {
            let target = diffs[i];
            let j = diffs.binary_search(&(target + 1)).unwrap_err();
            count += j as i32;
        }
        count
    }
}