public class Solution {

import java.util.*;

public class Solution {
    public int[] shiftingLetters(String s, int[] shifts) {
        int n = s.length();
        int[] result = new int[n];
        int totalShift = 0;

        for (int i = n - 1; i >= 0; i--) {
            totalShift = (totalShift + shifts[i]) % 26;
            result[i] = (s.charAt(i) - 'a' + totalShift) % 26;
        }

        for (int i = 0; i < n; i++) {
            result[i] = (result[i] + 'a') % 26 + 'a';
        }

        return result;
    }
}
}