import java.util.HashMap;
import java.util.Map;

class Solution {
    public int subarraySum(int[] nums, int k) {
        int count = 0;
        int currentSum = 0;
        Map<Integer, Integer> sumFrequency = new HashMap<>();
        sumFrequency.put(0, 1);

        for (int num : nums) {
            currentSum += num;
            if (sumFrequency.containsKey(currentSum - k)) {
                count += sumFrequency.get(currentSum - k);
            }
            sumFrequency.put(currentSum, sumFrequency.getOrDefault(currentSum, 0) + 1);
        }

        return count;
    }
}