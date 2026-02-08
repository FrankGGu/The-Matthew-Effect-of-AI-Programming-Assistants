import java.util.Arrays;

class Solution {
    public int maximizeGreatness(int[] nums) {
        Arrays.sort(nums);
        int count = 0;
        int j = 0;
        for (int i = 0; i < nums.length; i++) {
            while (j < nums.length && nums[j] <= nums[i]) {
                j++;
            }
            if (j < nums.length) {
                count++;
                j++;
            }
        }
        return count;
    }
}