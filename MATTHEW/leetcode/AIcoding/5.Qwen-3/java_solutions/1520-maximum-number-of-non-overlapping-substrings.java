public class Solution {

import java.util.*;

public class Solution {
    public List<String> maxNumOfSubstrings(String s) {
        int[] left = new int[26];
        int[] right = new int[26];
        Arrays.fill(left, -1);
        Arrays.fill(right, -1);

        for (int i = 0; i < s.length(); ++i) {
            int c = s.charAt(i) - 'a';
            if (left[c] == -1) left[c] = i;
            right[c] = i;
        }

        List<int[]> intervals = new ArrayList<>();
        for (int i = 0; i < 26; ++i) {
            if (left[i] != -1) {
                intervals.add(new int[]{left[i], right[i]});
            }
        }

        intervals.sort((a, b) -> a[0] - b[0]);

        List<String> result = new ArrayList<>();
        int lastEnd = -1;

        for (int[] interval : intervals) {
            if (interval[0] > lastEnd) {
                result.add(s.substring(interval[0], interval[1] + 1));
                lastEnd = interval[1];
            }
        }

        return result;
    }
}
}