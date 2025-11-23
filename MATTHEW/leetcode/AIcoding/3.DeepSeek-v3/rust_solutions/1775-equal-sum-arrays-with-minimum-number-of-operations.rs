use std::cmp::Ordering;

impl Solution {
    pub fn min_operations(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let sum1: i32 = nums1.iter().sum();
        let sum2: i32 = nums2.iter().sum();

        match sum1.cmp(&sum2) {
            Ordering::Equal => return 0,
            Ordering::Less => Self::solve(&nums1, &nums2, sum2 - sum1),
            Ordering::Greater => Self::solve(&nums2, &nums1, sum1 - sum2),
        }
    }

    fn solve(smaller: &[i32], larger: &[i32], diff: i32) -> i32 {
        let mut changes: Vec<i32> = Vec::new();

        for &num in smaller {
            changes.push(6 - num);
        }

        for &num in larger {
            changes.push(num - 1);
        }

        changes.sort_unstable_by(|a, b| b.cmp(a));

        let mut operations = 0;
        let mut remaining_diff = diff;

        for &change in changes.iter() {
            if remaining_diff <= 0 {
                break;
            }
            remaining_diff -= change;
            operations += 1;
        }

        if remaining_diff <= 0 {
            operations
        } else {
            -1
        }
    }
}