import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Deque;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public long numberOfSubarrays(int[] nums) {
        int n = nums.length;
        long ans = 0;

        Deque<Integer> stack = new ArrayDeque<>(); // Monotonic stack storing indices of elements in decreasing order
        Map<Integer, List<Integer>> valToIndices = new HashMap<>(); // Maps value to a sorted list of its indices

        for (int j = 0; j < n; j++) {
            // Maintain monotonic stack: pop elements that are less than or equal to nums[j]
            // This ensures stack.peek() (if exists) is the index of the previous strictly greater element
            while (!stack.isEmpty() && nums[stack.peek()] <= nums[j]) {
                stack.pop();
            }

            // prevGreaterIdx is the index of the first element to the left of j that is strictly greater than nums[j].
            // If no such element exists, it's -1.
            int prevGreaterIdx = stack.isEmpty() ? -1 : stack.peek();

            // Add current index 'j' to the list of indices for nums[j]
            valToIndices.computeIfAbsent(nums[j], k -> new ArrayList<>()).add(j);

            // Count valid 'i's for the current 'j'
            // A subarray nums[i...j] is valid if nums[i] == nums[j] and nums[k] <= nums[j] for all k in [i, j].
            // The second condition is satisfied if prevGreaterIdx < i <= j.
            // So, we need to count 'i' such that prevGreaterIdx < i <= j AND nums[i] == nums[j].
            List<Integer> indices = valToIndices.get(nums[j]);
            if (indices != null) {
                // Find the index of the first element in 'indices' that is >= (prevGreaterIdx + 1)
                int leftRangeBoundary = prevGreaterIdx + 1;
                int firstValidIdxInList = getLowerBound(indices, leftRangeBoundary);

                // Find the index of the first element in 'indices' that is > j
                // This effectively gives us the count of elements <= j
                int rightRangeBoundary = j;
                int firstIdxGreaterThanJInList = getUpperBound(indices, rightRangeBoundary);

                // The number of valid 'i's is the count of elements in 'indices'
                // within the range [firstValidIdxInList, firstIdxGreaterThanJInList - 1]
                ans += (firstIdxGreaterThanJInList - firstValidIdxInList);
            }

            // Push current index onto the stack
            stack.push(j);
        }

        return ans;
    }

    // Helper method to find the index of the first element >= val in a sorted list.
    // Equivalent to std::lower_bound in C++.
    private int getLowerBound(List<Integer> list, int val) {
        int low = 0, high = list.size() - 1;
        int ans = list.size(); // Default to list.size() if all elements are less than val
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (list.get(mid) >= val) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    // Helper method to find the index of the first element > val in a sorted list.
    // Equivalent to std::upper_bound in C++.
    private int getUpperBound(List<Integer> list, int val) {
        int low = 0, high = list.size() - 1;
        int ans = list.size(); // Default to list.size() if all elements are less than or equal to val
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (list.get(mid) > val) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
}