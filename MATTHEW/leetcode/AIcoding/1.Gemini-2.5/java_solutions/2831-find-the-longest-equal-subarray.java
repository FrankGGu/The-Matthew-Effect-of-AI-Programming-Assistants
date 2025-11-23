import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestEqualSubarray(int[] nums, int k) {
        int n = nums.length;
        int left = 0;
        int maxFreqInWindow = 0;
        int maxLen = 0; 

        Map<Integer, Integer> freqMap = new HashMap<>();

        for (int right = 0; right < n; right++) {
            int currentNum = nums[right];
            freqMap.put(currentNum, freqMap.getOrDefault(currentNum, 0) + 1);
            maxFreqInWindow = Math.max(maxFreqInWindow, freqMap.get(currentNum));

            // The condition for an invalid window is:
            // (current_window_length - max_frequency_of_any_element_in_window) > k
            // If this is true, we have too many elements that are not the most frequent one,
            // exceeding our allowed deletions 'k'. We must shrink the window from the left.
            while ((right - left + 1) - maxFreqInWindow > k) {
                int numToRemove = nums[left];
                freqMap.put(numToRemove, freqMap.get(numToRemove) - 1);
                left++;
                // Note: maxFreqInWindow is not explicitly re-calculated here.
                // This is a common optimization in sliding window problems.
                // maxFreqInWindow holds the highest frequency seen for any number
                // within the current (or a previously valid larger) window.
                // Even if the actual max frequency in the *current* shrunk window is lower,
                // if the condition `(right - left + 1) - maxFreqInWindow > k` still holds
                // (or held before shrinking), it means we still need to shrink.
                // If it becomes `(right - left + 1) - maxFreqInWindow <= k`,
                // then maxFreqInWindow is a valid candidate for the answer.
            }

            // At this point, the window [left, right] is valid, meaning
            // (right - left + 1) - maxFreqInWindow <= k.
            // This implies we can form an equal subarray of length maxFreqInWindow
            // by deleting at most k elements from nums[left...right].
            // We want to find the maximum possible length of such an equal subarray,
            // which is precisely maxFreqInWindow.
            maxLen = Math.max(maxLen, maxFreqInWindow);
        }

        return maxLen;
    }
}