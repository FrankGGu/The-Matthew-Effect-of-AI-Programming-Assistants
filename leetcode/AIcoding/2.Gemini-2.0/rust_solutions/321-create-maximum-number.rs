impl Solution {
    pub fn max_number(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<i32> {
        let n1 = nums1.len();
        let n2 = nums2.len();
        let k = k as usize;
        let mut ans = vec![0; k];

        for i in 0..=std::cmp::min(n1, k) {
            if k - i <= n2 {
                let mut candidate = Self::merge(&Self::max_array(&nums1, i), &Self::max_array(&nums2, k - i), k);
                if Self::greater(&candidate, 0, &ans, 0) {
                    ans = candidate;
                }
            }
        }

        ans
    }

    fn max_array(nums: &Vec<i32>, k: usize) -> Vec<i32> {
        let n = nums.len();
        let mut res = vec![0; k];
        let mut j = 0;
        for i in 0..n {
            while n - i + j > k && j > 0 && res[j - 1] < nums[i] {
                j -= 1;
            }
            if j < k {
                res[j] = nums[i];
                j += 1;
            }
        }
        res
    }

    fn merge(nums1: &Vec<i32>, nums2: &Vec<i32>, k: usize) -> Vec<i32> {
        let mut res = vec![0; k];
        let mut i = 0;
        let mut j = 0;
        for p in 0..k {
            if Self::greater(nums1, i, nums2, j) {
                res[p] = nums1[i];
                i += 1;
            } else {
                res[p] = nums2[j];
                j += 1;
            }
        }
        res
    }

    fn greater(nums1: &Vec<i32>, i: usize, nums2: &Vec<i32>, j: usize) -> bool {
        let mut i = i;
        let mut j = j;
        while i < nums1.len() && j < nums2.len() && nums1[i] == nums2[j] {
            i += 1;
            j += 1;
        }
        i < nums1.len() && (j == nums2.len() || nums1[i] > nums2[j])
    }
}