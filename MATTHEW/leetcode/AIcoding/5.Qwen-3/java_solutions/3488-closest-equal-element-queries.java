public class Solution {

import java.util.*;

public class Solution {
    public int[] closestEqual(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        Arrays.fill(result, -1);

        Map<Integer, Integer> lastIndexMap = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int num = nums[i];
            if (lastIndexMap.containsKey(num)) {
                int prevIndex = lastIndexMap.get(num);
                int distance = Math.min(i - prevIndex, prevIndex - i);
                result[i] = prevIndex;
            }
            lastIndexMap.put(num, i);
        }

        return result;
    }
}
}