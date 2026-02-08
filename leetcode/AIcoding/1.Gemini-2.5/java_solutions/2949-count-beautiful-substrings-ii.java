import java.util.HashMap;
import java.util.Map;

class Solution {

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    private long getTargetMultiple(int k) {
        if (k == 1) {
            return 1;
        }

        long targetMultiple = 1;
        int tempK = k;

        for (int i = 2; (long) i * i <= tempK; i++) {
            if (tempK % i == 0) {
                int count = 0;
                while (tempK % i == 0) {
                    count++;
                    tempK /= i;
                }
                int requiredPower = (count + 1) / 2;
                for (int j = 0; j < requiredPower; j++) {
                    targetMultiple *= i;
                }
            }
        }

        if (tempK > 1) {
            targetMultiple *= tempK;
        }
        return targetMultiple;
    }

    public long beautifulSubstrings(String s, int k) {
        int n = s.length();
        long targetMultiple = getTargetMultiple(k);

        long L_prime = 2 * targetMultiple;

        long ans = 0;
        int currentBalance = 0;

        Map<Integer, Map<Long, Integer>> freq = new HashMap<>();

        freq.computeIfAbsent(0, b -> new HashMap<>()).merge(0L, 1, Integer::sum);

        for (int j = 0; j < n; j++) {
            if (isVowel(s.charAt(j))) {
                currentBalance++;
            } else {
                currentBalance--;
            }

            long currentModVal = (long)(j + 1) % L_prime;

            Map<Long, Integer> innerMap = freq.get(currentBalance);
            if (innerMap != null) {
                ans += innerMap.getOrDefault(currentModVal, 0);
            }

            freq.computeIfAbsent(currentBalance, b -> new HashMap<>()).merge(currentModVal, 1, Integer::sum);
        }

        return ans;
    }
}