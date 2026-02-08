public class Solution {

import java.util.*;

public class Solution {
    public int minAnagramLength(String s) {
        int n = s.length();
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        for (int k = 1; k <= n; k++) {
            if (n % k != 0) continue;
            boolean valid = true;
            int[] temp = new int[26];
            for (int i = 0; i < k; i++) {
                temp[s.charAt(i) - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                if (temp[i] * (n / k) != freq[i]) {
                    valid = false;
                    break;
                }
            }
            if (valid) return k;
        }
        return n;
    }
}
}