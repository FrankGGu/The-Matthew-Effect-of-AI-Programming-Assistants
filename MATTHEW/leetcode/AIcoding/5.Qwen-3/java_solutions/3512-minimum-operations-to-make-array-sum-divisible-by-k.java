public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int minOperations(int[] nums, int k) {
        int n = nums.length;
        int[] prefixMod = new int[n];
        Map<Integer, Integer> modCount = new HashMap<>();
        modCount.put(0, 1);
        int currentMod = 0;
        int result = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            currentMod = (currentMod + nums[i]) % k;
            if (currentMod < 0) currentMod += k;
            prefixMod[i] = currentMod;
        }

        for (int i = 0; i < n; i++) {
            int targetMod = (prefixMod[i] - k) % k;
            if (modCount.containsKey(targetMod)) {
                result = Math.min(result, i + 1 - modCount.get(targetMod));
            }
            modCount.put(prefixMod[i], i + 1);
        }

        return result;
    }
}
}