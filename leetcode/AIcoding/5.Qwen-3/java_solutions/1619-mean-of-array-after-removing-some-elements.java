public class Solution {

import java.util.Arrays;

public class Solution {
    public double disgard(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int remove = n / 5;
        double sum = 0;
        for (int i = remove; i < n - remove; i++) {
            sum += nums[i];
        }
        return sum / (n - 2 * remove);
    }
}
}