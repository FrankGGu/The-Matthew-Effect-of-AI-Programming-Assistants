public class Solution {

import java.util.*;

public class Solution {
    public int countTheHiddenSequences(String s) {
        int n = s.length();
        int[] diff = new int[n];
        for (int i = 0; i < n; i++) {
            diff[i] = s.charAt(i) - '0';
        }

        int result = 1;
        int current = 1;
        for (int i = 1; i < n; i++) {
            if (diff[i] == diff[i - 1]) {
                current++;
            } else {
                current = 1;
            }
            result = Math.max(result, current);
        }

        return result;
    }
}
}