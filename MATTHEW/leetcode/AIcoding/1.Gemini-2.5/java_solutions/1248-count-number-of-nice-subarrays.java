import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numberOfSubarrays(int[] nums, int k) {
        Map<Integer, Integer> prefixOddCounts = new HashMap<>();
        prefixOddCounts.put(0, 1);
        int currentOddCount = 0;
        int niceSubarrays = 0;

        for (int num : nums) {
            if (num % 2 != 0) {
                currentOddCount++;
            }

            if (prefixOddCounts.containsKey(currentOddCount - k)) {
                niceSubarrays += prefixOddCounts.get(currentOddCount - k);
            }

            prefixOddCounts.put(currentOddCount, prefixOddCounts.getOrDefault(currentOddCount, 0) + 1);
        }

        return niceSubarrays;
    }
}