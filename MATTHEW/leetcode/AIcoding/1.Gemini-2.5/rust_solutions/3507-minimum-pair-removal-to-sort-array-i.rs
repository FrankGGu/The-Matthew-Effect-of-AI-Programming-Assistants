impl Solution {
    pub fn minimum_pair_removal_to_sort_array_i(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        // `tails` stores the smallest tail of all non-decreasing subsequences
        // of a certain length. `tails[i]` is the smallest ending element
        // of a non-decreasing subsequence of length `i+1`.
        let mut tails: Vec<i32> = Vec::new();

        for num in nums.iter() {
            // Find the index `idx` such that `tails[idx]` is the smallest element
            // in `tails` that is greater than or equal to `num`.
            // If `num` is greater than all elements in `tails`, `idx` will be `tails.len()`.
            let idx = match tails.binary_search(num) {
                Ok(i) => i,   // `num` is found in `tails` at index `i`.
                              // We can update `tails[i]` to `num` (which is a no-op)
                              // or simply use this index. This is valid for LNDS.
                Err(i) => i,  // `num` is not found, `i` is the insertion point.
                              // `tails[i]` would be the first element >= `num`.
            };

            if idx == tails.len() {
                // `num` is greater than all elements in `tails`.
                // This means we can extend the longest non-decreasing subsequence found so far.
                tails.push(*num);
            } else {
                // `num` can replace `tails[idx]` to form a non-decreasing subsequence
                // of the same length but with a smaller (or equal) ending element.
                // This potentially allows for longer subsequences later.
                tails[idx] = *num;
            }
        }

        // The length of `tails` at the end is the length of the Longest Non-Decreasing Subsequence (LNDS).
        // To sort the array, we need to remove all elements that are not part of the LNDS.
        // The minimum number of elements to remove is `total_length - LNDS_length`.
        (nums.len() - tails.len()) as i32
    }
}