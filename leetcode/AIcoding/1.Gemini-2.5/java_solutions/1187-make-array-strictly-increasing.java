import java.util.Arrays;
import java.util.TreeMap;
import java.util.Map;

class Solution {
    public int makeArrayIncreasing(int[] arr1, int[] arr2) {
        // Sort arr2 to efficiently find the smallest element greater than a given value.
        Arrays.sort(arr2);

        // dp is a TreeMap where:
        // Key: number of operations performed so far.
        // Value: the minimum value of the last element of a strictly increasing subsequence
        //        formed using that number of operations.
        // We initialize dp with a base case: 0 operations, and the previous element is -1
        // (which is smaller than any possible element in arr1 or arr2, allowing arr1[0] to be chosen).
        TreeMap<Integer, Integer> dp = new TreeMap<>();
        dp.put(0, -1); 

        // Iterate through each element of arr1.
        for (int num1 : arr1) {
            // next_dp will store the states for the current iteration (considering num1).
            TreeMap<Integer, Integer> next_dp = new TreeMap<>();

            // Iterate through all current valid states in dp.
            for (Map.Entry<Integer, Integer> entry : dp.entrySet()) {
                int ops = entry.getKey();        // Number of operations for this state
                int prev_val = entry.getValue(); // Last element value for this state

                // Option 1: Don't replace num1.
                // This is possible only if num1 is strictly greater than the previous element (prev_val).
                if (num1 > prev_val) {
                    // Update next_dp for 'ops' operations. We want the minimum possible last element.
                    next_dp.put(ops, Math.min(next_dp.getOrDefault(ops, Integer.MAX_VALUE), num1));
                }

                // Option 2: Replace num1 with an element from arr2.
                // We need to find the smallest element in arr2 that is strictly greater than prev_val.
                // Arrays.binarySearch returns:
                //   - The index of the search key, if it is contained in the array.
                //   - (-(insertion point) - 1) if the key is not in the array.
                // The insertion point is the index where the key would be inserted:
                // the index of the first element greater than the key, or arr2.length if all elements are less than the key.
                int idx = Arrays.binarySearch(arr2, prev_val + 1);
                if (idx < 0) {
                    idx = -idx - 1; // Convert to the actual insertion point
                }

                // If a suitable element exists in arr2 (i.e., idx is within bounds).
                if (idx < arr2.length) {
                    int new_val = arr2[idx];
                    int new_ops = ops + 1; // One more operation performed.

                    // Update next_dp for 'new_ops' operations with 'new_val'.
                    // Again, we take the minimum value if 'new_ops' already exists.
                    next_dp.put(new_ops, Math.min(next_dp.getOrDefault(new_ops, Integer.MAX_VALUE), new_val));
                }
            }

            // After processing all possibilities for the current num1 and populating next_dp,
            // we need to prune next_dp to maintain the property that for increasing 'ops',
            // the 'val' (minimum last element) must also be strictly increasing.
            // If we have (k1, v1) and (k2, v2) where k1 < k2 but v1 >= v2, then (k2, v2) is suboptimal.
            // We create a new TreeMap for dp and populate it with only optimal states from next_dp.
            dp = new TreeMap<>();
            for (Map.Entry<Integer, Integer> entry : next_dp.entrySet()) {
                int ops = entry.getKey();
                int val = entry.getValue();

                // Add the state if dp is empty (first state) or if the current 'val' is strictly greater
                // than the last element value recorded in dp (which corresponds to fewer operations).
                // If val <= dp.lastEntry().getValue(), this state is suboptimal and can be skipped.
                if (dp.isEmpty() || val > dp.lastEntry().getValue()) {
                    dp.put(ops, val);
                }
            }

            // If dp becomes empty at any point, it means no strictly increasing sequence can be formed
            // up to the current element of arr1.
            if (dp.isEmpty()) {
                return -1; 
            }
        }

        // After iterating through all elements of arr1, the dp map contains all possible
        // (operations, minimum_last_element) pairs for forming a strictly increasing array.
        // The problem asks for the minimum number of operations, which corresponds to the smallest key in dp.
        return dp.firstKey();
    }
}