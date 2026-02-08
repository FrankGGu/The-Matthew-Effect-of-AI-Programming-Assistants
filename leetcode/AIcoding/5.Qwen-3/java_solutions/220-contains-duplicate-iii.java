public class Solution {

import java.util.TreeSet;

public class Solution {
    public boolean containsNearbyDuplicate(int[] nums, int k, int t, int m) {
        if (nums == null || nums.length == 0 || k < 0 || t < 0 || m < 0) {
            return false;
        }
        TreeSet<Long> treeSet = new TreeSet<>();
        for (int i = 0; i < nums.length; i++) {
            long num = (long) nums[i];
            Long floor = treeSet.floor(num);
            Long ceiling = treeSet.ceiling(num);
            if (floor != null && num - floor <= t) {
                return true;
            }
            if (ceiling != null && ceiling - num <= t) {
                return true;
            }
            treeSet.add(num);
            if (i >= m) {
                treeSet.remove((long) nums[i - m]);
            }
        }
        return false;
    }
}
}