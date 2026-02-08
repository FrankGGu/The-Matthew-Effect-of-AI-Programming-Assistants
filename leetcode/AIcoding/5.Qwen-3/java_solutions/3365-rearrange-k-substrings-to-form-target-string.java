public class Solution {

import java.util.*;

public class Solution {
    public boolean canArrange(String s, String t, int k) {
        int n = s.length();
        int m = t.length();
        if (m % k != 0) return false;
        int len = m / k;
        Map<String, Integer> map = new HashMap<>();
        for (int i = 0; i < m; i += len) {
            String sub = t.substring(i, i + len);
            map.put(sub, map.getOrDefault(sub, 0) + 1);
        }
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            String sub = entry.getKey();
            int freq = entry.getValue();
            for (char c : sub.toCharArray()) {
                int idx = c - 'a';
                if (count[idx] < freq) return false;
                count[idx] -= freq;
            }
        }
        return true;
    }
}
}