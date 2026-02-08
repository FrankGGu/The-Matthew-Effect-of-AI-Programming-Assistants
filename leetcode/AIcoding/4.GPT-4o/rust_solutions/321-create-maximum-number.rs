pub struct Solution;

impl Solution {
    pub fn max_number(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut result = Vec::new();

        for i in 0..=k {
            if i > nums1.len() || (k - i) > nums2.len() {
                continue;
            }
            let mut max1 = Self::max_single_number(&nums1, i);
            let mut max2 = Self::max_single_number(&nums2, k - i);
            result = result.into_iter().chain(Self::merge(&mut max1, &mut max2)).collect();
        }

        result
    }

    fn max_single_number(nums: &[i32], k: usize) -> Vec<i32> {
        let mut stack = Vec::new();
        let mut drop = nums.len() - k;

        for &num in nums {
            while drop > 0 && !stack.is_empty() && *stack.last().unwrap() < num {
                stack.pop();
                drop -= 1;
            }
            stack.push(num);
        }

        stack.into_iter().take(k).collect()
    }

    fn merge(nums1: &mut Vec<i32>, nums2: &mut Vec<i32>) -> Vec<i32> {
        let mut merged = Vec::new();
        while !nums1.is_empty() || !nums2.is_empty() {
            if nums1 > nums2 {
                merged.push(nums1.remove(0));
            } else {
                merged.push(nums2.remove(0));
            }
        }
        merged
    }
}