import java.util.Arrays;

public class Solution {
    public int maxLength(int[] nums, int limit) {
        Arrays.sort(nums);
        int sum = 0, length = 0;

        for (int num : nums) {
            if (sum + num <= limit) {
                sum += num;
                length++;
            } else {
                break;
            }
        }

        return length;
    }
}