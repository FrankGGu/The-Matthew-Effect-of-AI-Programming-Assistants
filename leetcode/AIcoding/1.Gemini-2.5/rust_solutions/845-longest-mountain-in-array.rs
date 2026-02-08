impl Solution {
    pub fn longest_mountain(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n < 3 {
            return 0;
        }

        let mut max_len = 0;
        let mut i = 0;

        while i < n - 1 {
            // Skip flat or downhill segments to find a potential start of an uphill
            // A mountain must start with an uphill slope.
            while i < n - 1 && arr[i] >= arr[i+1] {
                i += 1;
            }

            // `i` is now at the start of a potential uphill segment (or end of array)
            let mut j = i;
            // Find the uphill part
            // A mountain must have an strictly increasing part
            while j < n - 1 && arr[j] < arr[j+1] {
                j += 1;
            }

            // If no uphill segment was found (j is still i), then it's not a mountain.
            // This can happen if `arr[i]` was the last element, or if `arr[i] >= arr[i+1]`.
            // We need to advance `i` to try finding a new uphill start.
            if j == i {
                i += 1;
                continue;
            }

            let peak_idx = j;

            // Find the downhill part
            // A mountain must have a strictly decreasing part after the peak
            while j < n - 1 && arr[j] > arr[j+1] {
                j += 1;
            }

            // If no downhill segment was found (j is still at peak_idx), then it's not a mountain.
            // (e.g., [1,2,3,4,5]). In this case, the `peak_idx` could be the start of a new uphill
            // or flat segment, so we continue searching from `peak_idx`.
            if j == peak_idx {
                i = peak_idx; 
                continue;
            }

            // We found a valid mountain from `i` to `j`
            max_len = max_len.max((j - i + 1) as i32);

            // Start the next search from the end of the current mountain's downhill part.
            // This ensures we don't re-evaluate elements that are part of the current mountain.
            i = j;
        }

        max_len
    }
}