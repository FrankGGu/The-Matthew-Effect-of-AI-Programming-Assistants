public class Solution {

import java.util.*;

public class Solution {
    public int selectKDisjointSpecialSubstrings(String s, int k) {
        int n = s.length();
        Set<String> special = new HashSet<>();
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                String sub = s.substring(i, j);
                if (isSpecial(sub)) {
                    special.add(sub);
                }
            }
        }
        List<String> list = new ArrayList<>(special);
        Collections.sort(list, (a, b) -> b.length() - a.length());
        int count = 0;
        int res = 0;
        int[] used = new int[n];
        for (String sub : list) {
            int len = sub.length();
            for (int i = 0; i <= n - len; i++) {
                boolean valid = true;
                for (int j = 0; j < len; j++) {
                    if (used[i + j] == 1) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    for (int j = 0; j < len; j++) {
                        used[i + j] = 1;
                    }
                    res += len;
                    count++;
                    if (count == k) {
                        return res;
                    }
                    break;
                }
            }
        }
        return -1;
    }

    private boolean isSpecial(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        for (int i = 0; i < 26; i++) {
            if (freq[i] > 1) {
                return false;
            }
        }
        return true;
    }
}
}