public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int countPerfectQuadruplets(int[] nums) {
        int n = nums.length;
        int count = 0;
        Map<Integer, Integer> map = new HashMap<>();

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int sum = nums[i] + nums[j];
                map.put(sum, map.getOrDefault(sum, 0) + 1);
            }
        }

        for (int k = 0; k < n; k++) {
            for (int l = k + 1; l < n; l++) {
                int diff = nums[k] - nums[l];
                count += map.getOrDefault(diff, 0);
            }
        }

        return count;
    }
}
}