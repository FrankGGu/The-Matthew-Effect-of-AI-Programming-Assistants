impl Solution {
    pub fn kth_smallest_product(nums1: Vec<i32>, nums2: Vec<i32>, k: i64) -> i64 {
        let mut low = -10_i64.pow(10);
        let mut high = 10_i64.pow(10);

        while low < high {
            let mid = low + (high - low) / 2;
            let mut count = 0;

            for &num1 in &nums1 {
                if num1 >= 0 {
                    let mut left = 0;
                    let mut right = nums2.len();

                    while left < right {
                        let m = left + (right - left) / 2;
                        if (num1 as i64) * (nums2[m] as i64) <= mid {
                            left = m + 1;
                        } else {
                            right = m;
                        }
                    }
                    count += left as i64;
                } else {
                    let mut left = 0;
                    let mut right = nums2.len();

                    while left < right {
                        let m = left + (right - left) / 2;
                        if (num1 as i64) * (nums2[m] as i64) <= mid {
                            right = m;
                        } else {
                            left = m + 1;
                        }
                    }
                    count += (nums2.len() - left) as i64;
                }
            }

            if count < k {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        low
    }
}