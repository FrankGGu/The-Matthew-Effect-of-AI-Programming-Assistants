import java.util.HashMap;
import java.util.Map;

class Solution {
    public long maximumSubarraySum(int[] nums, int k) {
        Map<Integer, Long> map = new HashMap<>();
        long ans = Long.MIN_VALUE;
        long sum = 0;
        for (int num : nums) {
            int target1 = num - k;
            int target2 = num + k;
            if (map.containsKey(target1)) {
                ans = Math.max(ans, sum + map.get(target1) + num);
            }
            if (map.containsKey(target2)) {
                ans = Math.max(ans, sum + map.get(target2) + num);
            }
            sum += num;
            map.put(num, Math.max(map.getOrDefault(num, Long.MIN_VALUE), sum));
        }
        return ans == Long.MIN_VALUE ? 0 : ans;
    }
}