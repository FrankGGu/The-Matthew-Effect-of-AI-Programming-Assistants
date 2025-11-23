import java.util.*;

class Solution {
    public int[] smallestSubarrays(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        Map<Integer, Integer> lastIndex = new HashMap<>();
        int maxOr = 0;

        for (int i = n - 1; i >= 0; i--) {
            maxOr |= nums[i];
            lastIndex.put(nums[i], i);
            int length = 1;
            int orValue = nums[i];
            for (int j = i + 1; j < n; j++) {
                orValue |= nums[j];
                length++;
                if (orValue == maxOr) {
                    break;
                }
            }
            result[i] = length;
        }

        for (int i = 0; i < n; i++) {
            result[i] = Math.max(result[i], 1);
        }

        return result;
    }
}