public class Solution {

import java.util.*;

public class Solution {
    public int countSubarrays(int[] nums, int k) {
        int n = nums.length;
        int maxVal = Arrays.stream(nums).max().getAsInt();
        int count = 0;
        int left = 0;
        int maxCount = 0;

        for (int right = 0; right < n; right++) {
            if (nums[right] == maxVal) {
                maxCount++;
            }

            while (maxCount >= k) {
                count += n - right;
                if (nums[left] == maxVal) {
                    maxCount--;
                }
                left++;
            }
        }

        return count;
    }
}
}