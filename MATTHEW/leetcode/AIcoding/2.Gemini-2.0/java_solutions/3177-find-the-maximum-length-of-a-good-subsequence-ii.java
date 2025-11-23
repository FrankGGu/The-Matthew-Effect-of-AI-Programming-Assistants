import java.util.ArrayList;
import java.util.List;

class Solution {
    public int findMaximumLength(int[] nums) {
        int n = nums.length;
        List<Long> dp = new ArrayList<>();
        long sum = 0;
        for (int i = 0; i < n; i++) {
            sum += nums[i];
            int l = 0, r = dp.size();
            while (l < r) {
                int mid = (l + r) / 2;
                if (dp.get(mid) <= sum) {
                    l = mid + 1;
                } else {
                    r = mid;
                }
            }
            if (l == dp.size()) {
                dp.add(sum + nums[i]);
            } else {
                dp.set(l, sum + nums[i]);
            }
        }
        return dp.size();
    }
}