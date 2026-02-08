import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minOperations(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        Map<Integer, Integer> count = new HashMap<>();
        for (int f : freq) {
            if (f > 0) {
                count.put(f, count.getOrDefault(f, 0) + 1);
            }
        }

        int ans = 0;
        while (true) {
            int maxFreq = 0;
            int maxCount = 0;
            for (int f : count.keySet()) {
                if (f > maxFreq) {
                    maxFreq = f;
                    maxCount = count.get(f);
                }
            }

            if (maxCount == 1) {
                if (maxFreq == 1) {
                    break;
                }
                ans++;
                count.put(maxFreq, count.get(maxFreq) - 1);
                if (maxFreq - 1 > 0) {
                    count.put(maxFreq - 1, count.getOrDefault(maxFreq - 1, 0) + 1);
                }
                if (count.get(maxFreq) == 0) {
                    count.remove(maxFreq);
                }
            } else {
                break;
            }
        }

        int sum = 0;
        for (int f : count.keySet()) {
            sum += count.get(f);
        }

        int target = 0;
        for (int f : count.keySet()) {
            target += count.get(f) * f;
        }

        int maxFreq = 0;
        for (int f : count.keySet()) {
            maxFreq = Math.max(maxFreq, f);
        }

        ans += s.length() - target;
        return ans;
    }
}