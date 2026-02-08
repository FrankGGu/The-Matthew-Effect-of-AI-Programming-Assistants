public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums) {
        if (nums.length == 1) return 0;

        Map<Integer, Integer> evenCount = new HashMap<>();
        Map<Integer, Integer> oddCount = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            if (i % 2 == 0) {
                evenCount.put(nums[i], evenCount.getOrDefault(nums[i], 0) + 1);
            } else {
                oddCount.put(nums[i], oddCount.getOrDefault(nums[i], 0) + 1);
            }
        }

        List<Map.Entry<Integer, Integer>> evenEntries = new ArrayList<>(evenCount.entrySet());
        List<Map.Entry<Integer, Integer>> oddEntries = new ArrayList<>(oddCount.entrySet());

        evenEntries.sort((a, b) -> b.getValue() - a.getValue());
        oddEntries.sort((a, b) -> b.getValue() - a.getValue());

        int maxEven = evenEntries.get(0).getValue();
        int maxOdd = oddEntries.get(0).getValue();

        if (evenEntries.get(0).getKey() != oddEntries.get(0).getKey()) {
            return nums.length - maxEven - maxOdd;
        } else {
            int secondMaxEven = evenEntries.size() > 1 ? evenEntries.get(1).getValue() : 0;
            int secondMaxOdd = oddEntries.size() > 1 ? oddEntries.get(1).getValue() : 0;
            return nums.length - Math.max(maxEven + secondMaxOdd, secondMaxEven + maxOdd);
        }
    }
}
}