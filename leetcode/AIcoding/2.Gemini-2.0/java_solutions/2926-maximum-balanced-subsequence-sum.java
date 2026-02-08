import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

class Solution {
    public long maxBalancedSubsequenceSum(int[] nums) {
        int n = nums.length;
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = nums[i] - (i + 1);
        }

        TreeMap<Integer, Long> map = new TreeMap<>();

        for (int i = 0; i < n; i++) {
            int key = arr[i];
            long val = nums[i];

            Long prevMax = map.floorKey(key) == null ? 0 : map.floorEntry(key).getValue();
            val += prevMax;

            Long currentMax = map.get(key);
            if (currentMax != null && currentMax >= val) {
                continue;
            }

            map.put(key, val);

            Map.Entry<Integer, Long> higherEntry = map.higherEntry(key);
            while (higherEntry != null && higherEntry.getValue() <= val) {
                map.remove(higherEntry.getKey());
                higherEntry = map.higherEntry(key);
            }
        }

        return map.isEmpty() ? -100000000000000L : map.lastEntry().getValue();
    }
}