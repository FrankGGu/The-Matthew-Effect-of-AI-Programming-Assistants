import java.util.Arrays;

public class Solution {
    public int minimizeOR(int[] nums) {
        Arrays.sort(nums);
        int result = 0;
        for (int num : nums) {
            result |= num;
        }
        return result;
    }
}