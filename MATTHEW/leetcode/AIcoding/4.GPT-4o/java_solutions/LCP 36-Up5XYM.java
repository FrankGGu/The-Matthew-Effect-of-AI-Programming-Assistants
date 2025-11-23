import java.util.HashMap;

public class Solution {
    public int maxEqualFreq(int[] nums) {
        HashMap<Integer, Integer> count = new HashMap<>();
        HashMap<Integer, Integer> freq = new HashMap<>();
        int maxFreq = 0, uniqueCount = 0;

        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        for (int c : count.values()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
            maxFreq = Math.max(maxFreq, c);
        }

        for (int i = 1; i <= maxFreq; i++) {
            if (freq.containsKey(i)) {
                int totalCount = 0, totalFreq = 0;

                for (int j : freq.keySet()) {
                    if (j == i) {
                        totalCount += freq.get(j) * j;
                        totalFreq += freq.get(j);
                    } else if (j == i + 1) {
                        totalCount += freq.get(j) * j;
                        totalFreq += freq.get(j);
                    } else {
                        totalCount += freq.get(j) * j;
                    }
                }

                if (totalCount == totalFreq * i || (totalFreq == 1 && (totalCount == totalFreq || totalCount - i == 0))) {
                    return totalCount;
                }
            }
        }

        return nums.length;
    }
}