impl Solution {
    pub fn maximum_score(nums1: Vec<i32>, nums2: Vec<i32>) -> i64 {
        let n = nums1.len();

        let sum_nums1: i64 = nums1.iter().map(|&x| x as i64).sum();
        let sum_nums2: i64 = nums2.iter().map(|&x| x as i64).sum();

        let kadane = |arr: Vec<i64>| -> i64 {
            let mut max_so_far = 0;
            let mut current_max = 0;
            for &x in arr.iter() {
                current_max += x;
                if current_max < 0 {
                    current_max = 0;
                }
                max_so_far = max_so_far.max(current_max);
            }
            max_so_far
        };

        let mut diff1_arr = Vec::with_capacity(n);
        for i in 0..n {
            diff1_arr.push(nums2[i] as i64 - nums1[i] as i64);
        }
        let max_gain1 = kadane(diff1_arr);
        let score1 = sum_nums1 + max_gain1;

        let mut diff2_arr = Vec::with_capacity(n);
        for i in 0..n {
            diff2_arr.push(nums1[i] as i64 - nums2[i] as i64);
        }
        let max_gain2 = kadane(diff2_arr);
        let score2 = sum_nums2 + max_gain2;

        score1.max(score2)
    }
}