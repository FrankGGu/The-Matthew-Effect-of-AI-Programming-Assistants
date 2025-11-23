public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> shiftingLetters(String s, int[] shifts) {
        int n = s.length();
        long[] totalShifts = new long[n];
        totalShifts[n - 1] = shifts[n - 1];

        for (int i = n - 2; i >= 0; i--) {
            totalShifts[i] = (totalShifts[i + 1] + shifts[i]) % 26;
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            int shifted = (c - 'a' + totalShifts[i]) % 26;
            if (shifted < 0) shifted += 26;
            result.add(shifted);
        }

        return result;
    }
}
}