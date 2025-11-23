struct Solution;

impl Solution {
    pub fn minimum_time(nums1: Vec<i32>, nums2: Vec<i32>, x: i32) -> i32 {
        let n = nums1.len();

        let check = |t: i64| -> bool {
            let mut current_sum: i64 = 0;
            for i in 0..n {
                let val1 = nums1[i] as i64;
                let val2 = nums2[i] as i64;
                current_sum += (val1 - t * val2).max(0);
                if current_sum > x as i64 {
                    return false;
                }
            }
            current_sum <= x as i64
        };

        let mut low: i64 = 0;
        let mut high: i64 = 2_000_000_000; 
        let mut ans: i64 = -1;

        while low <= high {
            let mid = low + (high - low) / 2;
            if check(mid) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        ans as i32
    }
}