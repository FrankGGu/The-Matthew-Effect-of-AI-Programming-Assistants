public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> numberOfArithmeticSlices(int[] nums) {
        List<Integer> result = new ArrayList<>();
        if (nums == null || nums.length < 3) {
            return result;
        }
        int n = nums.length;
        for (int i = 0; i < n - 2; i++) {
            int diff = nums[i + 1] - nums[i];
            for (int j = i + 2; j < n; j++) {
                if (nums[j] - nums[j - 1] == diff) {
                    result.add(j);
                } else {
                    break;
                }
            }
        }
        return result;
    }
}
}