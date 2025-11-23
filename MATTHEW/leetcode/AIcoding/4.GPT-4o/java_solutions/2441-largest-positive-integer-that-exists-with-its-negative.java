import java.util.HashSet;

class Solution {
    public int findMaxPositive(int[] nums) {
        HashSet<Integer> set = new HashSet<>();
        int max = -1;
        for (int num : nums) {
            if (num > 0) {
                set.add(num);
            }
        }
        for (int num : nums) {
            if (num < 0 && set.contains(-num)) {
                max = Math.max(max, -num);
            }
        }
        return max;
    }
}