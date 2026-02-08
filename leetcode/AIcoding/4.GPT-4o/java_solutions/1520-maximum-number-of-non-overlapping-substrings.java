import java.util.*;

public class Solution {
    public List<String> maxNumOfSubstrings(String s) {
        int n = s.length();
        int[] first = new int[26];
        int[] last = new int[26];

        for (int i = 0; i < n; i++) {
            int index = s.charAt(i) - 'a';
            if (first[index] == 0) first[index] = i + 1;
            last[index] = i + 1;
        }

        List<String> res = new ArrayList<>();
        int[] interval = new int[n + 1];

        for (int i = 0; i < 26; i++) {
            if (first[i] == 0) continue;
            int start = first[i] - 1;
            int end = last[i] - 1;
            int j = start;
            while (j <= end) {
                end = Math.max(end, last[s.charAt(j) - 'a'] - 1);
                j++;
            }
            interval[start] = end;
        }

        int end = -1;
        for (int i = 0; i < n; i++) {
            if (interval[i] == 0) continue;
            if (i > end) {
                res.add(s.substring(i, interval[i] + 1));
                end = interval[i];
            }
        }

        return res;
    }
}