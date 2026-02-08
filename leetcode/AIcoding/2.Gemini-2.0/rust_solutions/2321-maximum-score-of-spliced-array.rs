impl Solution {
    pub fn maximum_score(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut sum1 = 0;
        let mut sum2 = 0;
        for i in 0..n {
            sum1 += nums1[i];
            sum2 += nums2[i];
        }

        let mut diff1 = vec![0; n];
        let mut diff2 = vec![0; n];

        for i in 0..n {
            diff1[i] = nums2[i] - nums1[i];
            diff2[i] = nums1[i] - nums2[i];
        }

        let mut max_kadane1 = 0;
        let mut current_kadane1 = 0;
        for i in 0..n {
            current_kadane1 = (current_kadane1 + diff1[i]).max(0);
            max_kadane1 = max_kadane1.max(current_kadane1);
        }

        let mut max_kadane2 = 0;
        let mut current_kadane2 = 0;
        for i in 0..n {
            current_kadane2 = (current_kadane2 + diff2[i]).max(0);
            max_kadane2 = max_kadane2.max(current_kadane2);
        }

        (sum1 + max_kadane1).max(sum2 + max_kadane2)
    }
}