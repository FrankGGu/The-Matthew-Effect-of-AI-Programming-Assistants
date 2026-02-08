import java.util.HashSet;
import java.util.Set;

class Solution {
    public long numberOfExcellentPairs(int[] nums, int k) {
        Set<Integer> uniqueNums = new HashSet<>();
        for (int num : nums) {
            uniqueNums.add(num);
        }

        int[] freq = new int[31]; 
        for (int num : uniqueNums) {
            int bitCount = Integer.bitCount(num);
            freq[bitCount]++;
        }

        long excellentPairs = 0;

        for (int b1 = 0; b1 <= 30; b1++) {
            if (freq[b1] == 0) {
                continue;
            }
            for (int b2 = 0; b2 <= 30; b2++) {
                if (freq[b2] == 0) {
                    continue;
                }
                if (b1 + b2 >= k) {
                    excellentPairs += (long) freq[b1] * freq[b2];
                }
            }
        }

        return excellentPairs;
    }
}