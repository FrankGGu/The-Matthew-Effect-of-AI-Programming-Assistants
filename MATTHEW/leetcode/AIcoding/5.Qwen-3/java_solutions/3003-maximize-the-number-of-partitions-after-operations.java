public class Solution {

import java.util.*;

public class Solution {
    public int maxPartitions(int[] nums) {
        int n = nums.length;
        int[] next = new int[n];
        Arrays.fill(next, -1);
        Map<Integer, Integer> lastOccurrence = new HashMap<>();

        for (int i = 0; i < n; i++) {
            if (lastOccurrence.containsKey(nums[i])) {
                next[lastOccurrence.get(nums[i])] = i;
            }
            lastOccurrence.put(nums[i], i);
        }

        int partitions = 0;
        int end = -1;
        int i = 0;

        while (i < n) {
            end = Math.max(end, next[i]);
            if (i == end) {
                partitions++;
                i++;
            } else {
                i++;
            }
        }

        return partitions;
    }
}
}