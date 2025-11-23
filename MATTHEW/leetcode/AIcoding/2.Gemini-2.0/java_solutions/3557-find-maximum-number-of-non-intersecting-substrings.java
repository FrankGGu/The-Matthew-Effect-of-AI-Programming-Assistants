import java.util.*;

class Solution {
    public List<String> maxNumOfSubstrings(String s) {
        int n = s.length();
        int[] left = new int[26];
        int[] right = new int[26];
        Arrays.fill(left, n);
        Arrays.fill(right, -1);

        for (int i = 0; i < n; i++) {
            int c = s.charAt(i) - 'a';
            left[c] = Math.min(left[c], i);
            right[c] = Math.max(right[c], i);
        }

        List<int[]> intervals = new ArrayList<>();
        for (int i = 0; i < 26; i++) {
            if (left[i] < n) {
                int l = left[i];
                int r = right[i];
                int j = l;
                while (j <= r) {
                    int c = s.charAt(j) - 'a';
                    l = Math.min(l, left[c]);
                    r = Math.max(r, right[c]);
                    j++;
                }
                intervals.add(new int[]{l, r});
            }
        }

        Collections.sort(intervals, (a, b) -> a[1] - b[1]);

        List<String> result = new ArrayList<>();
        int last = -1;
        for (int[] interval : intervals) {
            if (interval[0] > last) {
                result.add(s.substring(interval[0], interval[1] + 1));
                last = interval[1];
            }
        }

        return result;
    }
}