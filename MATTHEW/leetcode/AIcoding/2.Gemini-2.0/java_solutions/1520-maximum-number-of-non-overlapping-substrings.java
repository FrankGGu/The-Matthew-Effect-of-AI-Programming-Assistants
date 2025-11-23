import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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

        List<String> result = new ArrayList<>();
        int end = -1;
        int start = 0;
        for (int i = 0; i < n; i++) {
            if (i == start) {
                int currEnd = right[s.charAt(i) - 'a'];
                int j = i;
                while (j <= currEnd) {
                    int c = s.charAt(j) - 'a';
                    if (left[c] < i) {
                        currEnd = -1;
                        break;
                    }
                    currEnd = Math.max(currEnd, right[c]);
                    j++;
                }

                if (currEnd != -1) {
                    if (end == -1 || currEnd < end) {
                        end = currEnd;
                    }

                }

            }

             if (i == end && end != -1) {
                result.add(s.substring(start, end + 1));
                start = i + 1;
                end = -1;

            }
        }

        return result;
    }
}