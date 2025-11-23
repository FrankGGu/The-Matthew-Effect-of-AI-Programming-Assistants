public class Solution {

import java.util.*;

public class Solution {
    public int lenLongestFibSubseq(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            indexMap.put(nums[i], i);
        }
        Map<String, Integer> dp = new HashMap<>();
        int maxLen = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                int prev = nums[i] - nums[j];
                if (indexMap.containsKey(prev)) {
                    int k = indexMap.get(prev);
                    String key = prev + "," + nums[j];
                    int len = dp.getOrDefault(key, 1) + 1;
                    dp.put(nums[j] + "," + nums[i], len);
                    maxLen = Math.max(maxLen, len);
                }
            }
        }
        return maxLen >= 2 ? maxLen : 0;
    }
}
}