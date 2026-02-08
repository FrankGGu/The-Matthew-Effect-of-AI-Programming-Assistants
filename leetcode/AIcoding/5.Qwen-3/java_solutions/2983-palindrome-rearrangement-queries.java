public class Solution {

import java.util.*;

public class Solution {
    public List<Boolean> canMakePalindromeQueries(String s, int[][] queries) {
        int n = s.length();
        List<Boolean> result = new ArrayList<>();
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        int oddCount = 0;
        for (int c : count) {
            if (c % 2 != 0) oddCount++;
        }

        int[][] prefix = new int[n + 1][26];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 26; j++) {
                prefix[i + 1][j] = prefix[i][j];
            }
            prefix[i + 1][s.charAt(i) - 'a']++;
        }

        for (int[] q : queries) {
            int l = q[0], r = q[1];
            int[] temp = new int[26];
            for (int i = 0; i < 26; i++) {
                temp[i] = prefix[r + 1][i] - prefix[l][i];
            }
            int newOdd = 0;
            for (int c : temp) {
                if (c % 2 != 0) newOdd++;
            }
            result.add(newOdd <= 1);
        }

        return result;
    }
}
}