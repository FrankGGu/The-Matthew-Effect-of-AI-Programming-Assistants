public class Solution {

import java.util.*;

public class Solution {
    public boolean canConstruct(String s, int k) {
        if (s.length() < k) {
            return false;
        }
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        int oddCount = 0;
        for (int i : count) {
            if (i % 2 != 0) {
                oddCount++;
            }
        }
        return oddCount <= k;
    }
}
}