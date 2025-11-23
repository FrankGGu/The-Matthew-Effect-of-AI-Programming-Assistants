public class Solution {

import java.util.*;

public class Solution {
    public int largestOuletlier(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int maxOutlier = Integer.MIN_VALUE;
        for (int num : nums) {
            int count = freq.get(num);
            if (count == 1) {
                if (num > maxOutlier) {
                    maxOutlier = num;
                }
            } else {
                int total = 0;
                for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
                    if (entry.getKey() != num) {
                        total += entry.getValue();
                    }
                }
                if (total == 1) {
                    if (num > maxOutlier) {
                        maxOutlier = num;
                    }
                }
            }
        }

        return maxOutlier;
    }
}
}