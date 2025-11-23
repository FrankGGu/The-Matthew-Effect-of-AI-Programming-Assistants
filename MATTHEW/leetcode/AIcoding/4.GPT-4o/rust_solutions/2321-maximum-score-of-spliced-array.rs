impl Solution {
    pub fn maximum_score(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let sum1: i32 = nums1.iter().sum();
        let sum2: i32 = nums2.iter().sum();

        let mut max_score = sum1 + sum2;

        for i in 0..n {
            let mut diff1 = 0;
            let mut diff2 = 0;

            for j in i..n {
                diff1 += nums1[j];
                diff2 += nums2[j];
                max_score = max_score.max(sum1 - diff1 + diff2);
                max_score = max_score.max(sum2 - diff2 + diff1);
            }
        }

        max_score
    }
}