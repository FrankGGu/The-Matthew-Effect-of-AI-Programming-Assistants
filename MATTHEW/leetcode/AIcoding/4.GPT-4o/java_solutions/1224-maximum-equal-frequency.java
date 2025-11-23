import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxEqualFreq(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        Map<Integer, Integer> freq = new HashMap<>();
        int maxFreq = 0;

        for (int num : nums) {
            if (count.containsKey(num)) {
                int c = count.get(num);
                if (c > 0) freq.put(c, freq.get(c) - 1);
                if (freq.get(c) == 0) freq.remove(c);
                count.put(num, c + 1);
                freq.put(c + 1, freq.getOrDefault(c + 1, 0) + 1);
            } else {
                count.put(num, 1);
                freq.put(1, freq.getOrDefault(1, 0) + 1);
            }
            maxFreq = Math.max(maxFreq, count.get(num));
            if (isValid(freq, maxFreq)) {
                return count.size();
            }
        }
        return count.size();
    }

    private boolean isValid(Map<Integer, Integer> freq, int maxFreq) {
        if (freq.size() == 1) {
            int onlyKey = freq.keySet().iterator().next();
            return onlyKey == 1 || freq.get(onlyKey) == 1;
        }
        if (freq.size() == 2) {
            int[] keys = new int[2];
            int i = 0;
            for (int key : freq.keySet()) {
                keys[i++] = key;
            }
            int k1 = keys[0], k2 = keys[1];
            if (k1 > k2) {
                int temp = k1;
                k1 = k2;
                k2 = temp;
            }
            return (k1 == 1 && freq.get(k1) == 1) || (k2 == k1 + 1 && freq.get(k2) == 1);
        }
        return false;
    }
}