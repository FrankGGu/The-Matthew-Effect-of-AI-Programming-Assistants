public class Solution {

import java.util.*;

public class Solution {
    public List<String> optimalDivision(int[] nums) {
        List<String> result = new ArrayList<>();
        if (nums == null || nums.length == 0) {
            return result;
        }
        if (nums.length == 1) {
            result.add(String.valueOf(nums[0]));
            return result;
        }
        if (nums.length == 2) {
            result.add(nums[0] + "/" + nums[1]);
            return result;
        }
        StringBuilder sb = new StringBuilder();
        sb.append(nums[0]).append("/(");
        for (int i = 1; i < nums.length - 1; i++) {
            sb.append(nums[i]).append("/");
        }
        sb.append(nums[nums.length - 1]).append(")");
        result.add(sb.toString());
        return result;
    }
}
}