import java.util.*;

public class Solution {
    public List<Boolean> canMakePaliQueries(String s, int[][] queries) {
        int n = s.length();
        int[][] count = new int[n + 1][26];
        for (int i = 0; i < n; i++) {
            count[i + 1] = count[i].clone();
            count[i + 1][s.charAt(i) - 'a']++;
        }

        List<Boolean> result = new ArrayList<>();
        for (int[] query : queries) {
            int left = query[0], right = query[1], k = query[2];
            int oddCount = 0;
            for (int i = 0; i < 26; i++) {
                if ((count[right + 1][i] - count[left][i]) % 2 != 0) {
                    oddCount++;
                }
            }
            result.add(oddCount / 2 <= k);
        }

        return result;
    }
}