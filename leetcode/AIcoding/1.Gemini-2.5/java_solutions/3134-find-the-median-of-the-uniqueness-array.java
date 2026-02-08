import java.util.HashMap;
import java.util.Map;

class Solution {
    public int findTheMedian(int[] nums) {
        int n = nums.length;
        long totalSubarrays = (long) n * (n + 1) / 2;
        // The k-th smallest element (1-indexed) is the median.
        // For an array of size M, the median is typically the element at index (M+1)/2 (1-indexed).
        long k = (totalSubarrays + 1) / 2; 

        int low = 1; // Minimum possible unique elements in a subarray is 1
        int high = n; // Maximum possible unique elements in a subarray is n
        int ans = n; // Initialize with a possible maximum value

        while (low <= high) {
            int mid = low + (high - low) / 2;
            // If there are 'k' or more subarrays with at most 'mid' unique elements,
            // then 'mid' could be our answer, or we might find a smaller one.
            if (countSubarraysWithAtMostXUnique(nums, mid) >= k) {
                ans = mid;
                high = mid - 1;
            } else {
                // Otherwise, 'mid' is too small; we need more unique elements.
                low = mid + 1;
            }
        }
        return ans;
    }

    // Helper function to count the number of subarrays with at most 'x' unique elements.
    private long countSubarraysWithAtMostXUnique(int[] nums, int x) {
        int n = nums.length;
        long count = 0;
        int left = 0;
        Map<Integer, Integer> freq = new HashMap<>();
        int currentUnique = 0;

        for (int right = 0; right < n; right++) {
            int num = nums[right];
            freq.put(num, freq.getOrDefault(num, 0) + 1);
            if (freq.get(num) == 1) { // If this is the first occurrence of num in the current window
                currentUnique++;
            }

            // Shrink the window from the left if currentUnique exceeds x
            while (currentUnique > x) {
                int leftNum = nums[left];
                freq.put(leftNum, freq.get(leftNum) - 1);
                if (freq.get(leftNum) == 0) { // If count of leftNum becomes 0, it's no longer unique
                    currentUnique--;
                }
                left++;
            }
            // At this point, the window nums[left...right] has currentUnique <= x.
            // All subarrays ending at 'right' and starting from 'left' up to 'right'
            // also satisfy the condition. There are (right - left + 1) such subarrays.
            count += (right - left + 1);
        }
        return count;
    }
}