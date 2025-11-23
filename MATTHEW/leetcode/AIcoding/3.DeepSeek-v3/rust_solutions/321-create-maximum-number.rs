impl Solution {
    pub fn max_number(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut res = vec![];
        for i in 0..=k {
            if i <= nums1.len() && k - i <= nums2.len() {
                let sub1 = Self::max_subsequence(&nums1, i);
                let sub2 = Self::max_subsequence(&nums2, k - i);
                let merged = Self::merge(&sub1, &sub2);
                if Self::compare(&merged, &res) {
                    res = merged;
                }
            }
        }
        res
    }

    fn max_subsequence(nums: &[i32], k: usize) -> Vec<i32> {
        let mut stack = vec![];
        let mut to_remove = nums.len() - k;
        for &num in nums {
            while !stack.is_empty() && to_remove > 0 && *stack.last().unwrap() < num {
                stack.pop();
                to_remove -= 1;
            }
            stack.push(num);
        }
        stack.truncate(k);
        stack
    }

    fn merge(nums1: &[i32], nums2: &[i32]) -> Vec<i32> {
        let mut res = vec![];
        let mut i = 0;
        let mut j = 0;
        while i < nums1.len() || j < nums2.len() {
            if Self::greater(nums1, i, nums2, j) {
                res.push(nums1[i]);
                i += 1;
            } else {
                res.push(nums2[j]);
                j += 1;
            }
        }
        res
    }

    fn greater(nums1: &[i32], i: usize, nums2: &[i32], j: usize) -> bool {
        let mut i = i;
        let mut j = j;
        while i < nums1.len() && j < nums2.len() {
            if nums1[i] != nums2[j] {
                return nums1[i] > nums2[j];
            }
            i += 1;
            j += 1;
        }
        i < nums1.len()
    }

    fn compare(nums1: &[i32], nums2: &[i32]) -> bool {
        if nums1.len() != nums2.len() {
            return nums1.len() > nums2.len();
        }
        for i in 0..nums1.len() {
            if nums1[i] != nums2[i] {
                return nums1[i] > nums2[i];
            }
        }
        false
    }
}