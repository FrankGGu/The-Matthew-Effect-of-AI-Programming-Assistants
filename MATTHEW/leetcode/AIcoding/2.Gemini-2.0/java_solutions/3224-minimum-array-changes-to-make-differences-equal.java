import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minChanges(int[] nums, int k) {
        int n = nums.length;
        int ans = 0;
        for (int i = 0; i < k; i++) {
            Map<Integer, Integer> counts = new HashMap<>();
            int maxCount = 0;
            int totalCount = 0;
            for (int j = i; j < n; j += k) {
                int num = nums[j];
                counts.put(num, counts.getOrDefault(num, 0) + 1);
                maxCount = Math.max(maxCount, counts.get(num));
                totalCount++;
            }
            ans += totalCount - maxCount;
        }
        return ans;
    }
}