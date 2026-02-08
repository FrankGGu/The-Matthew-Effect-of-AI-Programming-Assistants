import java.util.HashMap;
import java.util.Map;

class Solution {
    public int countGoodMeals(int[] deliciousness) {
        long count = 0;
        final int MOD = 1_000_000_007;

        int[] powersOfTwo = new int[22];
        for (int i = 0; i < 22; i++) {
            powersOfTwo[i] = 1 << i;
        }

        Map<Integer, Integer> freqMap = new HashMap<>();

        for (int num : deliciousness) {
            for (int p : powersOfTwo) {
                int complement = p - num;
                if (complement >= 0 && freqMap.containsKey(complement)) {
                    count = (count + freqMap.get(complement)) % MOD;
                }
            }
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        return (int) count;
    }
}