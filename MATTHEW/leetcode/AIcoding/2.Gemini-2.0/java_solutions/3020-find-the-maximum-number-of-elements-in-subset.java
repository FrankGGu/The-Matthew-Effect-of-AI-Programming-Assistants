import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maximumLength(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        Arrays.sort(nums);
        int ans = 0;
        for (int i = 0; i < nums.length; i++) {
            if (count.get(nums[i]) == 0) continue;
            int currLen = 1;
            long curr = nums[i];
            count.put(nums[i], count.get(nums[i]) - 1);

            while (true) {
                curr *= curr;
                if (count.containsKey((int)curr) && count.get((int)curr) > 0) {
                    currLen += 2;
                    count.put((int)curr, count.get((int)curr) - 1);
                } else {
                    break;
                }
            }
            ans = Math.max(ans, currLen);
        }

        if (count.containsKey(1)) {
            ans = Math.max(ans, count.get(1) % 2 == 0 ? count.get(1) - 1 : count.get(1));
        }
        return ans;
    }
}