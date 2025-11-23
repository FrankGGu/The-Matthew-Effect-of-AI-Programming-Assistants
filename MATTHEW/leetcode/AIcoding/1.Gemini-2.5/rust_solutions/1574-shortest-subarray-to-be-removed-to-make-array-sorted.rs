impl Solution {
    pub fn find_length_of_shortest_subarray(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n <= 1 {
            return 0;
        }

        let mut left_idx = 0;
        while left_idx + 1 < n && arr[left_idx] <= arr[left_idx + 1] {
            left_idx += 1;
        }

        if left_idx == n - 1 {
            return 0; // The entire array is already sorted
        }

        let mut right_idx = n - 1;
        while right_idx > 0 && arr[right_idx - 1] <= arr[right_idx] {
            right_idx -= 1;
        }

        // Initial minimum length of subarray to remove:
        // 1. Remove everything after the non-decreasing prefix (arr[left_idx+1 ... n-1]).
        //    Length: n - (left_idx + 1).
        // 2. Remove everything before the non-decreasing suffix (arr[0 ... right_idx-1]).
        //    Length: right_idx.
        let mut ans = (n - 1 - left_idx).min(right_idx);

        // Now, consider combining a non-decreasing prefix arr[0...p1] with a non-decreasing suffix arr[p2...n-1].
        // `p1` iterates through all possible end points of the valid prefix (from 0 to left_idx).
        // `p2` starts from `right_idx` and advances.
        let mut p2 = right_idx;
        for p1 in 0..=left_idx {
            // Advance `p2` until `arr[p1] <= arr[p2]` or `p2` reaches the end of the array.
            while p2 < n && arr[p1] > arr[p2] {
                p2 += 1;
            }

            // If `p2` reaches the end of the array, no more valid combinations for current or subsequent `p1`.
            if p2 == n {
                break;
            }

            // At this point, `arr[p1] <= arr[p2]` (or `p2` is `n`).
            // The elements to be removed are `arr[p1+1 ... p2-1]`.
            // The length of this subarray is `p2 - (p1 + 1)`.
            // If `p1 >= p2 - 1`, this length is 0 or negative. Since length must be non-negative,
            // we use `max(0, ...)` to handle cases where the prefix and suffix overlap or touch.
            ans = ans.min((p2 - p1 - 1).max(0));
        }

        ans as i32
    }
}