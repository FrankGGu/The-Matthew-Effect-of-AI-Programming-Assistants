public class Solution {
    public int theMaximumAchievableNumber(int k, int[] nums) {
        int max = 0;
        for (int num : nums) {
            max = Math.max(max, num);
        }
        return max + k;
    }
}