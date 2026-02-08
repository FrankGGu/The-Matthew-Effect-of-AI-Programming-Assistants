import java.util.HashMap;
import java.util.Map;

class Solution {
    public String longestSubsequenceRepeatedK(String s, int k) {
        Map<String, Integer> freqMap = new HashMap<>();
        int n = s.length();

        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                String sub = s.substring(i, i + len);
                freqMap.put(sub, freqMap.getOrDefault(sub, 0) + 1);
            }
        }

        String result = "";
        for (Map.Entry<String, Integer> entry : freqMap.entrySet()) {
            if (entry.getValue() >= k) {
                if (entry.getKey().length() > result.length()) {
                    result = entry.getKey();
                } else if (entry.getKey().length() == result.length() && entry.getKey().compareTo(result) < 0) {
                    result = entry.getKey();
                }
            }
        }

        return result;
    }
}