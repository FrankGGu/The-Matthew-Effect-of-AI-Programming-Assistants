import java.util.HashSet;

class Solution {
    public boolean findSubarrays(int[] nums) {
        HashSet<Integer> sums = new HashSet<>();
        for (int i = 0; i < nums.length - 1; i++) {
            int sum = nums[i] + nums[i + 1];
            if (sums.contains(sum)) {
                return true;
            }
            sums.add(sum);
        }
        return false;
    }
}