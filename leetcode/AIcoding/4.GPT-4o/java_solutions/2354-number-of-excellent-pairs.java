import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;

class Solution {
    public long countExcellentPairs(int[] nums, int k) {
        Set<Integer> uniqueNums = new HashSet<>();
        for (int num : nums) {
            uniqueNums.add(num);
        }

        int[] countBits = new int[32];
        for (int num : uniqueNums) {
            countBits[Integer.bitCount(num)]++;
        }

        long result = 0;
        for (int i = 0; i < 32; i++) {
            for (int j = 0; j < 32; j++) {
                if (i + j >= k) {
                    result += (long) countBits[i] * countBits[j];
                }
            }
        }

        return result;
    }
}