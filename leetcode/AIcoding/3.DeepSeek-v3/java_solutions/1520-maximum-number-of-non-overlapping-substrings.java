import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> maxNumOfSubstrings(String s) {
        int[] left = new int[26];
        int[] right = new int[26];
        Arrays.fill(left, Integer.MAX_VALUE);
        Arrays.fill(right, -1);
        for (int i = 0; i < s.length(); i++) {
            int c = s.charAt(i) - 'a';
            left[c] = Math.min(left[c], i);
            right[c] = Math.max(right[c], i);
        }
        List<String> res = new ArrayList<>();
        int prev = -1;
        for (int i = 0; i < s.length(); i++) {
            int c = s.charAt(i) - 'a';
            if (i == left[c]) {
                int end = check(s, i, left, right);
                if (end != -1) {
                    if (i > prev) {
                        res.add("");
                    }
                    prev = end;
                    res.set(res.size() - 1, s.substring(i, end + 1));
                }
            }
        }
        return res;
    }

    private int check(String s, int start, int[] left, int[] right) {
        int end = right[s.charAt(start) - 'a'];
        for (int i = start; i <= end; i++) {
            int c = s.charAt(i) - 'a';
            if (left[c] < start) {
                return -1;
            }
            end = Math.max(end, right[c]);
        }
        return end;
    }
}