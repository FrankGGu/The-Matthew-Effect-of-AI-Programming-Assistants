public class Solution {
    public int magicTower(int[] nums) {
        int total = 1, sum = 0, minHealth = 0;
        for (int num : nums) {
            sum += num;
            if (sum < 0) {
                minHealth += -sum;
                sum = 0;
            }
        }
        return total + minHealth;
    }
}