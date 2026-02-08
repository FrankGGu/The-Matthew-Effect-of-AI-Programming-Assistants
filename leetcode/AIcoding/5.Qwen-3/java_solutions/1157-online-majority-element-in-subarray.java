public class Solution {

import java.util.*;

public class MajorityChecker {
    private int[] nums;
    private Map<Integer, List<Integer>> indexMap;
    private Random random;

    public MajorityChecker(int[] nums) {
        this.nums = nums;
        indexMap = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            indexMap.computeIfAbsent(nums[i], k -> new ArrayList<>()).add(i);
        }
        random = new Random();
    }

    public int query(int left, int right, int threshold) {
        int candidate = nums[random.nextInt(right - left + 1) + left];
        int count = 0;
        for (int i = left; i <= right; i++) {
            if (nums[i] == candidate) {
                count++;
            }
        }
        return count >= threshold ? candidate : -1;
    }
}
}