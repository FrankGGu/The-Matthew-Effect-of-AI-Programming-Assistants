import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumOperations(int[] nums) {
        int n = nums.length;
        if (n <= 1) {
            return 0;
        }

        Map<Integer, Integer> evenCounts = new HashMap<>();
        Map<Integer, Integer> oddCounts = new HashMap<>();

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                evenCounts.put(nums[i], evenCounts.getOrDefault(nums[i], 0) + 1);
            } else {
                oddCounts.put(nums[i], oddCounts.getOrDefault(nums[i], 0) + 1);
            }
        }

        int maxEvenKey = 0, maxEvenCount = 0, secondMaxEvenKey = 0, secondMaxEvenCount = 0;
        for (Map.Entry<Integer, Integer> entry : evenCounts.entrySet()) {
            int key = entry.getKey();
            int count = entry.getValue();
            if (count > maxEvenCount) {
                secondMaxEvenKey = maxEvenKey;
                secondMaxEvenCount = maxEvenCount;
                maxEvenKey = key;
                maxEvenCount = count;
            } else if (count > secondMaxEvenCount) {
                secondMaxEvenKey = key;
                secondMaxEvenCount = count;
            }
        }

        int maxOddKey = 0, maxOddCount = 0, secondMaxOddKey = 0, secondMaxOddCount = 0;
        for (Map.Entry<Integer, Integer> entry : oddCounts.entrySet()) {
            int key = entry.getKey();
            int count = entry.getValue();
            if (count > maxOddCount) {
                secondMaxOddKey = maxOddKey;
                secondMaxOddCount = maxOddCount;
                maxOddKey = key;
                maxOddCount = count;
            } else if (count > secondMaxOddCount) {
                secondMaxOddKey = key;
                secondMaxOddCount = count;
            }
        }

        if (maxEvenKey != maxOddKey) {
            return n - maxEvenCount - maxOddCount;
        } else {
            return n - Math.max(maxEvenCount + secondMaxOddCount, maxOddCount + secondMaxEvenCount);
        }
    }
}