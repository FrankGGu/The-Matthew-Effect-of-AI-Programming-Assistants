use std::collections::HashSet;

impl Solution {
    pub fn find_the_integer_added_to_array_ii(mut nums1: Vec<i32>, mut nums2: Vec<i32>) -> Vec<i32> {
        nums1.sort_unstable();
        nums2.sort_unstable();

        let n = nums1.len();
        let m = nums2.len(); // m = n - 2

        let mut candidates: HashSet<i32> = HashSet::new();

        // Candidates based on nums2[0]
        // nums2[0] must be nums1[k] + x for some k.
        // k can be 0, 1, or 2, as at most two elements before nums1[k] could have been removed.
        for i in 0..=2 {
            candidates.insert(nums2[0] - nums1[i]);
        }

        // Candidates based on nums2[m-1] (the largest element in nums2)
        // nums2[m-1] must be nums1[k] + x for some k.
        // k can be n-1, n-2, or n-3, as at most two elements after nums1[k] could have been removed.
        for i in 0..=2 {
            candidates.insert(nums2[m - 1] - nums1[n - 1 - i]);
        }

        let mut result = Vec::new();
        for &x in candidates.iter() {
            if Self::check(x, &nums1, &nums2) {
                result.push(x);
            }
        }

        result.sort_unstable();
        result
    }

    // Helper function to check if a given x is valid
    fn check(x: i32, nums1: &[i32], nums2: &[i32]) -> bool {
        let n1_len = nums1.len();
        let n2_len = nums2.len();

        let mut n1_idx = 0;
        let mut n2_idx = 0;
        let mut removed_count = 0;

        while n1_idx < n1_len && n2_idx < n2_len {
            if nums1[n1_idx] + x == nums2[n2_idx] {
                n1_idx += 1;
                n2_idx += 1;
            } else if nums1[n1_idx] + x < nums2[n2_idx] {
                removed_count += 1;
                n1_idx += 1;
                if removed_count > 2 {
                    return false;
                }
            } else { // nums1[n1_idx] + x > nums2[n2_idx]
                return false;
            }
        }

        // All elements of nums2 must have been matched
        if n2_idx != n2_len {
            return false;
        }

        // The total number of elements from nums1 that were not matched to nums2 must be exactly 2.
        // These are the explicitly `removed_count` elements, plus any elements remaining in nums1
        // that were not processed (n1_len - n1_idx).
        removed_count + (n1_len - n1_idx) == 2
    }
}