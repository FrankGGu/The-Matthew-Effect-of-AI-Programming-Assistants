import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numberOfSubarrays(int[] nums, int k) {
        // The number of subarrays with exactly k odd numbers
        // is equal to (number of subarrays with at most k odd numbers)
        // minus (number of subarrays with at most k-1 odd numbers).
        return countSubarraysWithAtMostKOdds(nums, k) - countSubarraysWithAtMostKOdds(nums, k - 1);
    }

    private int countSubarraysWithAtMostKOdds(int[] nums, int k) {
        // If k is negative, it's impossible to have a subarray with at most a negative number of odds.
        // This handles the k-1 case when k=0, which would result in k=-1.
        if (k < 0) {
            return 0;
        }

        int count = 0;
        int left = 0;
        int oddCount = 0;

        // Iterate through the array with the 'right' pointer
        for (int right = 0; right < nums.length; right++) {
            // If the current number is odd, increment the odd count
            if (nums[right] % 2 != 0) {
                oddCount++;
            }

            // While the number of odd elements in the current window (nums[left...right])
            // exceeds k, shrink the window from the left.
            while (oddCount > k) {
                // If the element leaving the window from the left is odd, decrement odd count
                if (nums[left] % 2 != 0) {
                    oddCount--;
                }
                left++; // Move the left pointer to shrink the window
            }

            // At this point, the subarray nums[left...right] has at most k odd numbers.
            // All subarrays ending at 'right' and starting from any point between 'left' and 'right'
            // (inclusive) also satisfy the condition.
            // The number of such subarrays is (right - left + 1).
            count += (right - left + 1);
        }
        return count;
    }
}