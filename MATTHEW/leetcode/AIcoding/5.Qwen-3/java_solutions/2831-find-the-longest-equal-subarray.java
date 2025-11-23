public class Solution {

import java.util.*;

public class Solution {
    public int longestEqualSubarray(int[] nums, int k) {
        Map<Integer, List<Integer>> indexMap = new HashMap<>();
        for (int i = 0; i < nums.length; ++i) {
            indexMap.computeIfAbsent(nums[i], x -> new ArrayList<>()).add(i);
        }

        int maxLength = 0;
        for (List<Integer> indices : indexMap.values()) {
            int left = 0;
            for (int right = 0; right < indices.size(); ++right) {
                while (indices.get(right) - indices.get(left) - right + left > k) {
                    left++;
                }
                maxLength = Math.max(maxLength, right - left + 1);
            }
        }
        return maxLength;
    }
}
}