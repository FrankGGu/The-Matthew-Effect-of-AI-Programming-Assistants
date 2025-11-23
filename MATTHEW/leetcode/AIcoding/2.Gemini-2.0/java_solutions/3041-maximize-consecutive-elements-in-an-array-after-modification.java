import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxConsecutive(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int ans = 0;
        for (int i = 0; i < n; i++) {
            int target = nums[i];
            int count = 0;
            Map<Integer, Integer> freq = new HashMap<>();
            int cost = 0;
            for (int j = 0; j < n; j++) {
                int diff = Math.abs(nums[j] - target);
                if (diff <= 2) {
                    if (diff == 0) {
                        count++;
                    } else if (diff == 1) {
                        if (freq.getOrDefault(nums[j], 0) < 1) {
                            count++;
                            freq.put(nums[j], freq.getOrDefault(nums[j], 0) + 1);
                            cost++;
                        }
                    } else {
                        if (freq.getOrDefault(nums[j], 0) < 2) {
                            count++;
                            freq.put(nums[j], freq.getOrDefault(nums[j], 0) + 1);
                            cost++;
                        }
                    }
                }
            }
            ans = Math.max(ans, count);
        }
        return ans;
    }
}