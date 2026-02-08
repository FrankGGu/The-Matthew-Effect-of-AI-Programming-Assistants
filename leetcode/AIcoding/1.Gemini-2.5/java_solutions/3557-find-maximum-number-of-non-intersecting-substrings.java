import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

class Solution {
    public List<String> maxNumOfSubstrings(String s) {
        int n = s.length();
        int[] first = new int[26];
        int[] last = new int[26];
        Arrays.fill(first, -1);

        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (first[c - 'a'] == -1) {
                first[c - 'a'] = i;
            }
            last[c - 'a'] = i;
        }

        List<int[]> validSubstrings = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            // Check if 'i' is the first occurrence of s.charAt(i)
            if (i == first[s.charAt(i) - 'a']) {
                int currentEnd = last[s.charAt(i) - 'a'];
                boolean isValidStart = true;

                // Expand the substring to the right, ensuring all characters within have their first occurrence >= i
                // and update currentEnd to cover all characters' last occurrences.
                // The loop variable k starts from i and goes up to currentEnd.
                // If currentEnd expands, k continues up to the new currentEnd.
                for (int k = i; k <= currentEnd; k++) {
                    char c = s.charAt(k);
                    if (first[c - 'a'] < i) { // Character 'c' appears before 'i', so s[i...currentEnd] is not valid
                        isValidStart = false;
                        break;
                    }
                    currentEnd = Math.max(currentEnd, last[c - 'a']); // Extend currentEnd if 'c' ends later
                }

                if (isValidStart) {
                    validSubstrings.add(new int[]{i, currentEnd});
                }
            }
        }

        // Sort valid substrings by their end positions. If end positions are same, sort by length.
        Collections.sort(validSubstrings, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                if (a[1] != b[1]) {
                    return a[1] - b[1]; // Sort by end ascending
                }
                return (a[1] - a[0]) - (b[1] - b[0]); // Sort by length ascending
            }
        });

        List<String> result = new ArrayList<>();
        int prevEnd = -1;

        for (int[] sub : validSubstrings) {
            int start = sub[0];
            int end = sub[1];

            if (start > prevEnd) { // If this substring does not overlap with the previously chosen one
                result.add(s.substring(start, end + 1));
                prevEnd = end;
            }
        }

        return result;
    }
}