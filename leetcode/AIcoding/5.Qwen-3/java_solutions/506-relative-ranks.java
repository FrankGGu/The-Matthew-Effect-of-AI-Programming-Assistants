public class Solution {

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class RelativeRanks {
    public String[] findRelativeRanks(int[] nums) {
        int n = nums.length;
        int[] sorted = Arrays.copyOf(nums, n);
        Arrays.sort(sorted);
        Map<Integer, String> rankMap = new HashMap<>();

        for (int i = n - 1; i >= 0; i--) {
            if (i == n - 1) {
                rankMap.put(sorted[i], "Gold Medal");
            } else if (i == n - 2) {
                rankMap.put(sorted[i], "Silver Medal");
            } else if (i == n - 3) {
                rankMap.put(sorted[i], "Bronze Medal");
            } else {
                rankMap.put(sorted[i], String.valueOf(n - i));
            }
        }

        String[] result = new String[n];
        for (int i = 0; i < n; i++) {
            result[i] = rankMap.get(nums[i]);
        }

        return result;
    }
}
}