impl Solution {
    pub fn count_range_sum(nums: Vec<i32>, lower: i32, upper: i32) -> i32 {
        let n = nums.len();
        let mut sums = vec![0i64; n + 1];
        for i in 0..n {
            sums[i + 1] = sums[i] + nums[i] as i64;
        }

        fn merge_sort_and_count(sums: &mut [i64], lower: i64, upper: i64) -> i32 {
            if sums.len() <= 1 {
                return 0;
            }

            let mid = sums.len() / 2;
            let mut left = sums[..mid].to_vec();
            let mut right = sums[mid..].to_vec();

            let mut count = merge_sort_and_count(&mut left, lower, upper) + merge_sort_and_count(&mut right, lower, upper);

            let mut i = 0;
            let mut j = 0;
            let mut k = 0;
            let mut l = 0;
            for &left_val in &left {
                while k < right.len() && right[k] - left_val < lower {
                    k += 1;
                }
                while l < right.len() && right[l] - left_val <= upper {
                    l += 1;
                }
                count += (l - k) as i32;
            }

            let mut li = 0;
            let mut ri = 0;
            let mut sorted = Vec::new();

            while li < left.len() && ri < right.len() {
                if left[li] < right[ri] {
                    sorted.push(left[li]);
                    li += 1;
                } else {
                    sorted.push(right[ri]);
                    ri += 1;
                }
            }

            sorted.extend_from_slice(&left[li..]);
            sorted.extend_from_slice(&right[ri..]);

            sums.copy_from_slice(&sorted);

            count
        }

        merge_sort_and_count(&mut sums, lower as i64, upper as i64)
    }
}