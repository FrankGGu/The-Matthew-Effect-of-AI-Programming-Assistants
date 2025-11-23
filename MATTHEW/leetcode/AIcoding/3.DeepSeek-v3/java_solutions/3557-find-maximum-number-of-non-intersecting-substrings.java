import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

class Solution {
    public List<String> maxNumOfSubstrings(String s) {
        int[] left = new int[26];
        int[] right = new int[26];
        Arrays.fill(left, s.length());
        for (int i = 0; i < s.length(); i++) {
            int c = s.charAt(i) - 'a';
            left[c] = Math.min(left[c], i);
            right[c] = Math.max(right[c], i);
        }
        List<int[]> intervals = new ArrayList<>();
        for (int c = 0; c < 26; c++) {
            if (left[c] == s.length()) continue;
            int l = left[c];
            int r = right[c];
            boolean valid = true;
            for (int i = l; i <= r; i++) {
                int curr = s.charAt(i) - 'a';
                if (left[curr] < l) {
                    valid = false;
                    break;
                }
                r = Math.max(r, right[curr]);
            }
            if (valid) {
                intervals.add(new int[]{l, r});
            }
        }
        Collections.sort(intervals, Comparator.comparingInt(a -> a[1]));
        List<String> res = new ArrayList<>();
        int prevEnd = -1;
        for (int[] interval : intervals) {
            if (interval[0] > prevEnd) {
                res.add(s.substring(interval[0], interval[1] + 1));
                prevEnd = interval[1];
            }
        }
        return res;
    }
}