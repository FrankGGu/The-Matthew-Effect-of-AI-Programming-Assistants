import java.util.TreeMap;

class Solution {
    public int lengthOfLIS(int[] nums, int k) {
        TreeMap<Integer, Integer> dp = new TreeMap<>();
        for (int num : nums) {
            Integer lowerKey = dp.lowerKey(num);
            int len = (lowerKey == null) ? 0 : dp.get(lowerKey);

            Integer higherKey = dp.ceilingKey(num + 1);
            if (higherKey != null && higherKey <= num + k) {
                len = Math.max(len, dp.get(higherKey));
            }

            len++;

            Integer ceilingKey = dp.ceilingKey(num);
            if (ceilingKey != null && dp.get(ceilingKey) >= len) {
                continue;
            }

            dp.put(num, len);

            higherKey = dp.higherKey(num);
            while (higherKey != null && dp.get(higherKey) <= len) {
                dp.remove(higherKey);
                higherKey = dp.higherKey(num);
            }
        }
        int maxLen = 0;
        for (int len : dp.values()) {
            maxLen = Math.max(maxLen, len);
        }
        return maxLen;
    }
}