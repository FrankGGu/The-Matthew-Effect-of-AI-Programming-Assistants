import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int longestEqualSubarray(int[] nums, int k) {
        Map<Integer, List<Integer>> valToIndices = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            valToIndices.computeIfAbsent(nums[i], key -> new ArrayList<>()).add(i);
        }

        int maxLength = 0;
        for (List<Integer> indices : valToIndices.values()) {
            int left = 0;
            for (int right = 0; right < indices.size(); right++) {
                // Calculate deletions for the current window of 'indices' from 'left' to 'right'.
                // The window in the original 'nums' array spans from indices.get(left) to indices.get(right).
                // The total number of elements in this span of the original array is:
                int spanLengthInOriginalArray = indices.get(right) - indices.get(left) + 1;

                // The number of elements of the current value (which is nums[indices.get(left)])
                // within this window [left, right] of 'indices' is:
                int countOfCurrentValue = right - left + 1;

                // The number of elements that are NOT the current value within the span
                // and thus need to be deleted is:
                int deletionsNeeded = spanLengthInOriginalArray - countOfCurrentValue;

                // If deletions needed exceed k, shrink the window from the left
                while (deletionsNeeded > k) {
                    left++;
                    // Recalculate deletions for the new, smaller window [left, right]
                    spanLengthInOriginalArray = indices.get(right) - indices.get(left) + 1;
                    countOfCurrentValue = right - left + 1;
                    deletionsNeeded = spanLengthInOriginalArray - countOfCurrentValue;
                }

                // At this point, deletionsNeeded <= k, so the current window [left, right]
                // represents a valid equal subarray.
                // The length of this equal subarray is countOfCurrentValue.
                maxLength = Math.max(maxLength, countOfCurrentValue);
            }
        }

        return maxLength;
    }
}