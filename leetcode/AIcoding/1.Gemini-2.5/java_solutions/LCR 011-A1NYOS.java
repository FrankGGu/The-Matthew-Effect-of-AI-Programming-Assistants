import java.util.HashMap;
import java.util.Map;

class Solution {
    public int findMaxLength(int[] nums) {
        Map<Integer, Integer> sumIndexMap = new HashMap<>();
        sumIndexMap.put(0, -1);
        int maxLength = 0;
        int currentSum = 0;

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 0) {
                currentSum--;
            } else {
                currentSum++;
            }

            if (sumIndexMap.containsKey(currentSum)) {
                maxLength = Math.max(maxLength, i - sumIndexMap.get(currentSum));
            } else {
                sumIndexMap.put(currentSum, i);
            }
        }

        return maxLength;
    }
}