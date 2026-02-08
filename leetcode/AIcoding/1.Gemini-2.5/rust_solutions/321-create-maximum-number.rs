impl Solution {
    pub fn max_number(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let n1 = nums1.len();
        let n2 = nums2.len();
        let mut max_res = vec![];

        for i in 0..=k {
            let j = k - i;

            if i <= n1 && j <= n2 {
                let sub_res1 = Solution::max_array(&nums1, i);
                let sub_res2 = Solution::max_array(&nums2, j);

                let merged = Solution::merge(&sub_res1, &sub_res2);

                if Solution::is_greater(&merged, &max_res) {
                    max_res = merged;
                }
            }
        }
        max_res
    }

    fn max_array(nums: &[i32], k: usize) -> Vec<i32> {
        if k == 0 {
            return vec![];
        }
        let mut stack = Vec::with_capacity(k);
        let n = nums.len();
        let mut drop_count = n - k;

        for &num in nums.iter() {
            while drop_count > 0 && !stack.is_empty() && num > *stack.last().unwrap() {
                stack.pop();
                drop_count -= 1;
            }
            stack.push(num);
        }

        while stack.len() > k {
            stack.pop();
        }
        stack
    }

    fn merge(nums1: &[i32], nums2: &[i32]) -> Vec<i32> {
        let mut result = Vec::with_capacity(nums1.len() + nums2.len());
        let mut i = 0;
        let mut j = 0;

        while i < nums1.len() || j < nums2.len() {
            if i < nums1.len() && j < nums2.len() {
                if Solution::is_greater(&nums1[i..], &nums2[j..]) {
                    result.push(nums1[i]);
                    i += 1;
                } else {
                    result.push(nums2[j]);
                    j += 1;
                }
            } else if i < nums1.len() {
                result.push(nums1[i]);
                i += 1;
            } else {
                result.push(nums2[j]);
                j += 1;
            }
        }
        result
    }

    fn is_greater(s1: &[i32], s2: &[i32]) -> bool {
        let mut i = 0;
        let mut j = 0;
        while i < s1.len() && j < s2.len() {
            if s1[i] > s2[j] {
                return true;
            }
            if s1[i] < s2[j] {
                return false;
            }
            i += 1;
            j += 1;
        }
        s1.len() > s2.len()
    }
}