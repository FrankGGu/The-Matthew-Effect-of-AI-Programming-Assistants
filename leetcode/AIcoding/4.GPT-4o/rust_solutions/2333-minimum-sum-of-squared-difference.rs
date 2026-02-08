pub fn minimum_sum_of_squared_difference(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
    let n = nums1.len();
    let mut sum = 0;
    let mut max_diff = 0;

    for i in 0..n {
        let diff = (nums1[i] - nums2[i]).abs();
        sum += diff * diff;
        max_diff = max_diff.max(diff);
    }

    sum - max_diff * max_diff
}