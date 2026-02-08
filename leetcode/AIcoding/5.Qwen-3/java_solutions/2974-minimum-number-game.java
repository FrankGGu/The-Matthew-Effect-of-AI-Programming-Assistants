public class Solution {

import java.util.Arrays;

public class Solution {
    public int minNumber(int[] nums) {
        Arrays.sort(nums);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < nums.length; i += 2) {
            sb.append(nums[i]);
        }
        return Integer.parseInt(sb.toString());
    }
}
}