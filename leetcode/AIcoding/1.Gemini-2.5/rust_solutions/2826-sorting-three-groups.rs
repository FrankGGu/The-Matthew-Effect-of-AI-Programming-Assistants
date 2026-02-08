impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        // `tails[k]` stores the smallest ending element of a non-decreasing subsequence of length `k+1`.
        // This `tails` array will always be sorted in strictly increasing order.
        let mut tails: Vec<i32> = Vec::new();

        for num in nums {
            // Find the insertion point for `num` in `tails` to maintain sorted order.
            // For a non-decreasing subsequence:
            // - If `num` is already present in `tails` (Ok(i)), it means we already have
            //   a non-decreasing subsequence of length `i+1` ending with `num` (or a smaller value).
            //   No action is needed as `tails` should store the smallest possible ending element.
            // - If `num` is not present (Err(i)), `i` is the index where `num` would be inserted
            //   to maintain sorted order.
            match tails.binary_search(&num) {
                Ok(_) => {
                    // `num` is already in `tails`. We don't need to update anything
                    // because `tails` already contains the smallest ending element for that length.
                }
                Err(i) => {
                    // `num` is not in `tails`, and `i` is the index where it should be inserted.
                    if i == tails.len() {
                        // `num` is greater than all elements currently in `tails`.
                        // It extends the longest non-decreasing subsequence found so far.
                        tails.push(num);
                    } else {
                        // `num` is smaller than `tails[i]`.
                        // By replacing `tails[i]` with `num`, we form a non-decreasing subsequence
                        // of length `i+1` that ends with a smaller value. This is beneficial
                        // for potentially extending this subsequence further with future elements.
                        tails[i] = num;
                    }
                }
            }
        }

        // The length of `tails` at the end represents the length of the Longest Non-Decreasing Subsequence (LNDS).
        // The minimum number of operations to make the entire array non-decreasing is
        // the total number of elements minus the length of the LNDS.
        (n - tails.len()) as i32
    }
}