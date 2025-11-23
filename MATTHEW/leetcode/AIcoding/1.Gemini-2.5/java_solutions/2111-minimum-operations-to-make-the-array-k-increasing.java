import java.util.ArrayList;
import java.util.List;

class Solution {
    public int kIncreasing(int[] arr, int k) {
        int n = arr.length;
        int totalOperations = 0;

        for (int i = 0; i < k; i++) {
            List<Integer> tails = new ArrayList<>();
            int currentSubsequenceLength = 0;

            // Iterate through the current k-subsequence
            for (int j = i; j < n; j += k) {
                int num = arr[j];
                currentSubsequenceLength++;

                // Find the index 'low' where 'num' should be inserted to maintain non-decreasing order.
                // This is equivalent to finding the upper_bound for 'num' in 'tails'.
                // 'low' will be the index of the first element strictly greater than 'num'.
                int low = 0;
                int high = tails.size();
                while (low < high) {
                    int mid = low + (high - low) / 2;
                    if (tails.get(mid) <= num) {
                        // If element at mid is less than or equal to 'num',
                        // we need to look in the right half for a strictly greater element.
                        low = mid + 1;
                    } else {
                        // If element at mid is strictly greater than 'num',
                        // it could be our candidate, or we might find an even smaller one in the left half.
                        high = mid;
                    }
                }

                // At the end of the binary search, 'low' is the index of the first element
                // in 'tails' that is strictly greater than 'num'.
                // If 'low == tails.size()', it means all elements in 'tails' are less than or equal to 'num',
                // so 'num' extends the longest non-decreasing subsequence.
                if (low == tails.size()) {
                    tails.add(num);
                } else {
                    // Otherwise, replace the element at 'low' with 'num'.
                    // This maintains the length of the non-decreasing subsequence but results in a
                    // smaller ending element, which is more favorable for extending the subsequence later.
                    tails.set(low, num);
                }
            }

            // The number of operations for this subsequence is its total length minus
            // the length of its Longest Non-Decreasing Subsequence (LNDS).
            totalOperations += (currentSubsequenceLength - tails.size());
        }

        return totalOperations;
    }
}