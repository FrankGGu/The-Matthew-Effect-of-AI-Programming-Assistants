public class Solution {

import java.util.*;

public class Solution {
    public int numBadPairs(int[] nums) {
        Map<Integer, Integer> map = new HashMap<>();
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            map.put(nums[i], map.getOrDefault(nums[i], 0) + 1);
        }
        int total = 0;
        for (int count : map.values()) {
            total += count * (count - 1) / 2;
        }
        return n * (n - 1) / 2 - total;
    }
}
}