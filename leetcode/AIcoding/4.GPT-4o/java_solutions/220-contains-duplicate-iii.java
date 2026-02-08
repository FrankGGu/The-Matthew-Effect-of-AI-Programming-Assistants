import java.util.TreeSet;

public class Solution {
    public boolean containsNearbyAlmostDuplicate(int[] nums, int k, int t) {
        if (k <= 0 || t < 0) return false;
        TreeSet<Long> set = new TreeSet<>();
        for (int i = 0; i < nums.length; i++) {
            long num = (long) nums[i];
            if (set.floor(num + t) != null && set.floor(num + t) >= num - t) return true;
            set.add(num);
            if (i >= k) set.remove((long) nums[i - k]);
        }
        return false;
    }
}