public class Solution {

import java.util.*;

public class Solution {
    public int[] vowelStrings(String[] words, int[][] queries) {
        int n = words.length;
        int[] prefix = new int[n];
        int count = 0;
        for (int i = 0; i < n; i++) {
            String word = words[i];
            if ((word.charAt(0) == 'a' || word.charAt(0) == 'e' || word.charAt(0) == 'i' || word.charAt(0) == 'o' || word.charAt(0) == 'u') &&
                (word.charAt(word.length() - 1) == 'a' || word.charAt(word.length() - 1) == 'e' || word.charAt(word.length() - 1) == 'i' || word.charAt(word.length() - 1) == 'o' || word.charAt(word.length() - 1) == 'u')) {
                count++;
            }
            prefix[i] = count;
        }
        int m = queries.length;
        int[] result = new int[m];
        for (int i = 0; i < m; i++) {
            int l = queries[i][0];
            int r = queries[i][1];
            if (l == 0) {
                result[i] = prefix[r];
            } else {
                result[i] = prefix[r] - prefix[l - 1];
            }
        }
        return result;
    }
}
}