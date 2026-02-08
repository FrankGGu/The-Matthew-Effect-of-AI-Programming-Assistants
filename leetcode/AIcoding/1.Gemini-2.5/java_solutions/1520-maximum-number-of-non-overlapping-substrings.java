import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<String> maxNumOfSubstrings(String s) {
        int n = s.length();
        int[] first = new int[26];
        int[] last = new int[26];
        Arrays.fill(first, n); // Initialize first occurrences to n (a value greater than any valid index)

        for (int i = 0; i < n; i++) {
            int charIdx = s.charAt(i) - 'a';
            first[charIdx] = Math.min(first[charIdx], i);
            last[charIdx] = Math.max(last[charIdx], i);
        }

        List<int[]> validSubstrings = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            int charIdx = s.charAt(i) - 'a';

            // If 'i' is not the first occurrence of s.charAt(i),
            // then any substring starting at 'i' that contains s.charAt(i) will not contain its first occurrence.
            // Thus, 'i' cannot be the start of a valid substring.
            if (first[charIdx] != i) {
                continue;
            }

            // Now, i is a potential start of a valid substring.
            // We need to find the smallest 'j' such that s[i...j] is valid.
            // The 'currentEnd' of the candidate substring must extend to cover all last occurrences
            // of characters within the current window [i...k].
            int currentEnd = last[charIdx];
            boolean isValidStart = true;

            // Expand the window from 'i' to 'currentEnd' to find the true 'end'
            // and check if any character's first occurrence is before 'i'.
            for (int k = i; k <= currentEnd; k++) {
                int kCharIdx = s.charAt(k) - 'a';
                if (first[kCharIdx] < i) { // If any character within s[i...currentEnd] appears before 'i',
                                           // then s[i...currentEnd] is not a valid substring starting at 'i'.
                    isValidStart = false;
                    break;
                }
                currentEnd = Math.max(currentEnd, last[kCharIdx]); // Extend 'currentEnd' if necessary
            }

            if (isValidStart) {
                validSubstrings.add(new int[]{i, currentEnd});
            }
        }

        // Sort valid substrings.
        // The greedy approach for maximum non-overlapping intervals is to sort by end points.
        // If end points are equal, to minimize total length (as per problem statement),
        // we should pick the shorter substring.
        validSubstrings.sort((a, b) -> {
            if (a[1] != b[1]) {
                return a[1] - b[1]; // Sort by end point ascending
            }
            return (a[1] - a[0]) - (b[1] - b[0]); // If end points are equal, sort by length ascending
        });

        List<String> result = new ArrayList<>();
        int prevEnd = -1; // Keep track of the end of the last picked substring

        for (int[] sub : validSubstrings) {
            int start = sub[0];
            int end = sub[1];

            if (start > prevEnd) { // If the current substring does not overlap with the previous one
                result.add(s.substring(start, end + 1));
                prevEnd = end;
            }
        }

        return result;
    }
}