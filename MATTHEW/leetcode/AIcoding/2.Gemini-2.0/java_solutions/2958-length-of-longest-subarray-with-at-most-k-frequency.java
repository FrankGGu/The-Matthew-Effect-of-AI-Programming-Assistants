import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxSubarrayLength(int[] nums, int k) {
        int left = 0;
        int maxLength = 0;
        Map<Integer, Integer> frequencyMap = new HashMap<>();

        for (int right = 0; right < nums.length; right++) {
            int num = nums[right];
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);

            while (frequencyMap.get(num) > k) {
                int leftNum = nums[left];
                frequencyMap.put(leftNum, frequencyMap.get(leftNum) - 1);
                left++;
            }

            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}