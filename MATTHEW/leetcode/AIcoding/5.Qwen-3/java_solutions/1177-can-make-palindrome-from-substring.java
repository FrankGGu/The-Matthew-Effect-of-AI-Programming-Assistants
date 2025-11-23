public class Solution {

import java.util.*;

public class Solution {
    public List<Boolean> canMakePalindromeQueries(String s, int[][] queries) {
        int n = s.length();
        List<Boolean> result = new ArrayList<>();
        int[][] prefix = new int[n + 1][26];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 26; j++) {
                prefix[i + 1][j] = prefix[i][j];
            }
            prefix[i + 1][s.charAt(i) - 'a']++;
        }

        for (int[] query : queries) {
            int l = query[0], r = query[1];
            int[] count = new int[26];
            for (int i = l; i <= r; i++) {
                count[s.charAt(i) - 'a']++;
            }
            boolean possible = true;
            for (int i = 0; i < 26; i++) {
                if (count[i] % 2 != 0) {
                    possible = false;
                    break;
                }
            }
            result.add(possible);
        }

        return result;
    }
}
}