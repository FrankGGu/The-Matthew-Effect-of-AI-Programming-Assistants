public class Solution {

import java.util.*;

public class Solution {
    public int maximumLength(String s) {
        Map<String, Integer> count = new HashMap<>();
        int n = s.length();
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            int j = i;
            while (j < n && s.charAt(j) == c) j++;
            int len = j - i;
            for (int k = 1; k <= len; k++) {
                String sub = String.valueOf(c).repeat(k);
                count.put(sub, count.getOrDefault(sub, 0) + 1);
            }
            i = j - 1;
        }

        int maxLen = -1;
        for (Map.Entry<String, Integer> entry : count.entrySet()) {
            if (entry.getValue() >= 3) {
                maxLen = Math.max(maxLen, entry.getKey().length());
            }
        }
        return maxLen;
    }
}
}