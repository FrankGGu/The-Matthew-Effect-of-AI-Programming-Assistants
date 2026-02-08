import java.util.Arrays;

public class Solution {
    public int maximumElements(int[] nums, int limit, int num) {
        Arrays.sort(nums);
        int count = 0;
        long sum = 0;

        for (int i = 0; i < nums.length; i++) {
            if (count < num && sum + nums[i] <= limit) {
                sum += nums[i];
                count++;
            } else if (count >= num) {
                break;
            }
        }
        return count;
    }
}