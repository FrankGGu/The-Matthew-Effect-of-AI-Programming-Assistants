import java.util.HashMap;
import java.util.Map;

class Solution {
    public long beautifulSubstrings(String s, int k) {
        int n = s.length();
        long ans = 0;
        int vowels = 0;
        Map<Integer, Long> count = new HashMap<>();
        count.put(0, 1L);
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowels++;
            }
            int consonants = (i + 1) - vowels;
            int diff = vowels - consonants;
            int key = diff % k;
            if (key < 0) key += k;
            ans += count.getOrDefault(key, 0L);
            count.put(key, count.getOrDefault(key, 0L) + 1);
        }
        return ans;
    }
}