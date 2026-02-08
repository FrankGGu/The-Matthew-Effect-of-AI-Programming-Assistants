public class Solution {

import java.util.*;

public class Solution {
    public int maxOperationsWithSameScoreII(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        List<Map.Entry<Integer, Integer>> entries = new ArrayList<>(countMap.entrySet());
        entries.sort((a, b) -> b.getValue() - a.getValue());

        int maxOperations = 0;
        int currentSum = 0;
        int currentCount = 0;

        for (Map.Entry<Integer, Integer> entry : entries) {
            int value = entry.getKey();
            int freq = entry.getValue();

            if (currentCount == 0) {
                currentSum = value;
                currentCount = freq;
            } else {
                if (currentSum + value == currentSum) {
                    currentCount += freq;
                } else {
                    maxOperations = Math.max(maxOperations, currentCount);
                    currentSum = value;
                    currentCount = freq;
                }
            }
        }

        maxOperations = Math.max(maxOperations, currentCount);

        return maxOperations;
    }
}
}