public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int subarraysDivByK(int[] nums, int k) {
        int n = nums.length;
        int[] prefixMod = new int[n];
        prefixMod[0] = nums[0] % k;
        for (int i = 1; i < n; i++) {
            prefixMod[i] = (prefixMod[i - 1] + nums[i]) % k;
        }

        Map<Integer, Integer> modCount = new HashMap<>();
        modCount.put(0, 1);
        int result = 0;

        for (int i = 0; i < n; i++) {
            int mod = prefixMod[i];
            if (mod < 0) {
                mod += k;
            }
            result += modCount.getOrDefault(mod, 0);
            modCount.put(mod, modCount.getOrDefault(mod, 0) + 1);
        }

        return result;
    }
}
}