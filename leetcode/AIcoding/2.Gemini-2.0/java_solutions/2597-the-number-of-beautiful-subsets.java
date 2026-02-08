import java.util.HashMap;
import java.util.Map;

class Solution {
    public int beautifulSubsets(int[] nums, int k) {
        int n = nums.length;
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int count = 1;
        Map<Integer, Integer> dp = new HashMap<>();

        for (int num : nums) {
            int currentCount = freq.get(num);
            freq.remove(num);

            int prevCount = dp.getOrDefault(num - k, 0);
            int nextCount = dp.getOrDefault(num + k, 0);

            dp.put(num, (1 << currentCount) - 1);
            count += (1 << currentCount) - 1;

            if (prevCount > 0) {
                count -= prevCount * ((1 << currentCount) - 1);
                dp.put(num, dp.get(num) - prevCount);
            }
            if (nextCount > 0) {
                 count -= nextCount * ((1 << currentCount) - 1);
                 dp.put(num, dp.get(num) - nextCount);
            }
        }

        return count;
    }
}