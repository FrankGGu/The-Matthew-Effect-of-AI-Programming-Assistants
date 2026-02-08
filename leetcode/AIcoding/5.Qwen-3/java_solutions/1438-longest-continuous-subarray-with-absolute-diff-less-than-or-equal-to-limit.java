public class Solution {

import java.util.*;

public class Solution {
    public int longestSubarray(int[] nums, int limit) {
        int n = nums.length;
        int left = 0;
        int result = 0;
        TreeMap<Integer, Integer> treeMap = new TreeMap<>();

        for (int right = 0; right < n; right++) {
            treeMap.put(nums[right], treeMap.getOrDefault(nums[right], 0) + 1);

            while (treeMap.lastKey() - treeMap.firstKey() > limit) {
                treeMap.put(nums[left], treeMap.get(nums[left]) - 1);
                if (treeMap.get(nums[left]) == 0) {
                    treeMap.remove(nums[left]);
                }
                left++;
            }

            result = Math.max(result, right - left + 1);
        }

        return result;
    }
}
}