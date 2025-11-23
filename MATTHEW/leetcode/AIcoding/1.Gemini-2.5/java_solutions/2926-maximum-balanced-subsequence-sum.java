import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

class Solution {

    // Segment Tree fields
    private long[] tree;
    private int M; // Size of the distinct coordinates array (number of leaves in the segment tree)

    // Segment Tree initializer
    private void initSegmentTree(int size) {
        this.M = size;
        // The segment tree array needs to be at most 4 times the number of leaves for typical 1-indexed implementations
        tree = new long[4 * M];
        // All values are initialized to 0 by default for long arrays, which is suitable for max queries
    }

    // Segment Tree update operation
    // Updates the value at targetIdx (rank) in the conceptual array to 'value'.
    // Stores the maximum value seen for that index.
    private void update(int nodeIdx, int start, int end, int targetIdx, long value) {
        // Base case: leaf node
        if (start == end) {
            tree[nodeIdx] = Math.max(tree[nodeIdx], value);
            return;
        }

        int mid = start + (end - start) / 2;
        if (targetIdx <= mid) {
            update(2 * nodeIdx, start, mid, targetIdx, value);
        } else {
            update(2 * nodeIdx + 1, mid + 1, end, targetIdx, value);
        }
        // Update parent node with the maximum of its children
        tree[nodeIdx] = Math.max(tree[2 * nodeIdx], tree[2 * nodeIdx + 1]);
    }

    // Segment Tree query operation
    // Queries for the maximum value in the range [queryL, queryR] (inclusive ranks)
    private long query(int nodeIdx, int start, int end, int queryL, int queryR) {
        // Case 1: No overlap between query range and current node's range
        if (queryR < start || queryL > end) {
            return 0L; // Return 0 as it's the identity for max operation with non-negative sums
        }

        // Case 2: Full overlap - current node's range is completely within query range
        if (queryL <= start && end <= queryR) {
            return tree[nodeIdx];
        }

        // Case 3: Partial overlap - recurse on children
        int mid = start + (end - start) / 2;
        long p1 = query(2 * nodeIdx, start, mid, queryL, queryR);
        long p2 = query(2 * nodeIdx + 1, mid + 1, end, queryL, queryR);
        return Math.max(p1, p2);
    }

    public long maxBalancedSubsequenceSum(int[] nums) {
        int N = nums.length;

        // 1. Collect all y_i = nums[i] - i values
        List<Integer> y_values = new ArrayList<>();
        for (int i = 0; i < N; i++) {
            y_values.add(nums[i] - i);
        }

        // 2. Sort and remove duplicates to get distinct coordinates for compression
        Collections.sort(y_values);
        int[] distinct_y = y_values.stream().distinct().mapToInt(Integer::intValue).toArray();

        // M is the number of distinct coordinates (size of the compressed range for the segment tree)
        M = distinct_y.length;

        // Initialize segment tree with M leaves
        initSegmentTree(M);

        // maxTotalSum stores the overall maximum balanced subsequence sum found.
        // Since nums[i] >= 1, a single element subsequence is always valid and has a positive sum.
        // Initializing with 0L is safe because any valid subsequence will have a sum >= 1.
        long maxTotalSum = 0L; 

        // Iterate through the original array
        for (int i = 0; i < N; i++) {
            int current_y = nums[i] - i;

            // Find the rank (index) of current_y in the distinct_y array
            int rank_current_y = Arrays.binarySearch(distinct_y, current_y);

            // Query the segment tree for the maximum sum in the range of ranks [0, rank_current_y].
            // This finds the maximum sum of a balanced subsequence ending at some index j < i,
            // such that nums[j] - j <= nums[i] - i.
            // The query uses 1-based indexing for the root node (1), and 0 to M-1 for the rank range.
            long prev_max_sum = query(1, 0, M - 1, 0, rank_current_y);

            // Calculate the current subsequence sum by adding nums[i] to the maximum previous sum.
            // If prev_max_sum is 0, it means no valid previous elements were found, so nums[i] starts a new subsequence.
            long current_sum = nums[i] + prev_max_sum;

            // Update the segment tree at rank_current_y with current_sum.
            // The update operation stores the maximum sum found so far for subsequences ending with current_y.
            update(1, 0, M - 1, rank_current_y, current_sum);

            // Update the overall maximum sum
            maxTotalSum = Math.max(maxTotalSum, current_sum);
        }

        return maxTotalSum;
    }
}