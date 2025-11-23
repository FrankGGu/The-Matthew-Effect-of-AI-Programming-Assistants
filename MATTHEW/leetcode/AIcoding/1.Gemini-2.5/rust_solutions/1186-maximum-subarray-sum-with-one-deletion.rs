impl Solution {
    pub fn maximum_sum(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n == 0 {
            return 0; // Or handle as per problem constraints, usually empty array sum is 0 or error.
                      // LeetCode constraints usually guarantee non-empty arrays for this type of problem.
                      // For this problem, n is at least 1.
        }

        let mut max_overall_sum = arr[0];
        let mut curr_max_no_del = arr[0]; // Maximum subarray sum ending at current index without any deletion
        let mut curr_max_with_del = 0;    // Maximum subarray sum ending at current index with one deletion

        // Initialize curr_max_with_del.
        // If we consider the first element `arr[0]`:
        // - If we don't delete anything, sum is `arr[0]`.
        // - If we delete `arr[0]`, the sum is effectively `0` (empty prefix before `arr[1]`).
        //   However, `curr_max_with_del` is for a subarray *ending* at the current index.
        //   If we delete `arr[0]`, the subarray cannot end at `arr[0]`.
        //   So, `curr_max_with_del` for `i=0` should represent the case where `arr[0]` is deleted,
        //   and the "subarray" is empty, contributing 0.
        //   This initialization effectively means that if the first element is deleted, the sum up to that point is 0.
        //   This will be correctly handled by `max(curr_max_with_del + num, curr_max_no_del)` where `curr_max_no_del`
        //   will be `arr[i-1]` if `arr[i]` is deleted.
        //   For `i=0`, `curr_max_with_del` being 0 is a good starting point for the "delete current element" path.

        for i in 1..n {
            let num = arr[i];

            // Calculate new_curr_max_with_del first, as it depends on the OLD curr_max_no_del.
            // Option 1: Extend previous subarray with deletion by adding current num.
            // Option 2: Delete current num, and take the sum of the subarray ending at previous index without deletion.
            let new_curr_max_with_del = curr_max_with_del + num;
            let new_curr_max_with_del = std::cmp::max(new_curr_max_with_del, curr_max_no_del);

            // Calculate new_curr_max_no_del.
            // Option 1: Start a new subarray with current num.
            // Option 2: Extend previous subarray without deletion by adding current num.
            let new_curr_max_no_del = std::cmp::max(num, curr_max_no_del + num);

            curr_max_no_del = new_curr_max_no_del;
            curr_max_with_del = new_curr_max_with_del;

            max_overall_sum = std::cmp::max(max_overall_sum, curr_max_no_del);
            max_overall_sum = std::cmp::max(max_overall_sum, curr_max_with_del);
        }

        max_overall_sum
    }
}