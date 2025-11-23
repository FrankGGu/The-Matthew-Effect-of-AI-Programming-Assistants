impl Solution {
    fn solve(n: usize, nums1: &[i32], nums2: &[i32], target_val1: i32, target_val2: i32) -> usize {
        let mut swaps = 0;
        for i in 0..n - 1 {
            let a = nums1[i];
            let b = nums2[i];

            let can_keep = a <= target_val1 && b <= target_val2;
            let can_swap = b <= target_val1 && a <= target_val2;

            if can_keep && can_swap {
                // Both options work, prefer keeping (0 cost)
                continue;
            } else if can_keep {
                // Only keeping works (0 cost)
                continue;
            } else if can_swap {
                // Only swapping works (1 cost)
                swaps += 1;
            } else {
                // Neither keeping nor swapping works, impossible
                return usize::MAX;
            }
        }
        swaps
    }

    pub fn min_operations(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();

        let mut ans = usize::MAX;

        // Scenario 1: No swap at index n-1
        // The last elements are nums1[n-1] and nums2[n-1]
        let res1 = Solution::solve(n, &nums1, &nums2, nums1[n - 1], nums2[n - 1]);
        ans = ans.min(res1);

        // Scenario 2: Swap at index n-1
        // The last elements become nums2[n-1] and nums1[n-1]
        let res2 = Solution::solve(n, &nums1, &nums2, nums2[n - 1], nums1[n - 1]);
        if res2 != usize::MAX {
            ans = ans.min(res2 + 1); // Add 1 for the swap at index n-1
        }

        if ans == usize::MAX {
            -1
        } else {
            ans as i32
        }
    }
}