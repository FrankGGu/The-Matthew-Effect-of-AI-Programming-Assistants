public class Solution {

import java.util.*;

public class Solution {
    public int maxOperations(String s) {
        int n = s.length();
        int[] left = new int[n];
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == 'A') {
                count++;
            } else {
                left[i] = count;
            }
        }
        count = 0;
        int[] right = new int[n];
        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == 'A') {
                count++;
            } else {
                right[i] = count;
            }
        }
        int max = 0;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == 'B') {
                int leftVal = i > 0 ? left[i - 1] : 0;
                int rightVal = i < n - 1 ? right[i + 1] : 0;
                max = Math.max(max, leftVal + rightVal);
            }
        }
        return max;
    }
}
}