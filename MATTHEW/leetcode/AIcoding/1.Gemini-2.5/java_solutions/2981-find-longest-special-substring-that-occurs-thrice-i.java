import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int longestSpecialSubstring(String s) {
        int n = s.length();
        Map<Character, List<Integer>> charRunLengths = new HashMap<>();

        int i = 0;
        while (i < n) {
            char currentChar = s.charAt(i);
            int j = i;
            while (j < n && s.charAt(j) == currentChar) {
                j++;
            }
            int runLength = j - i;
            charRunLengths.computeIfAbsent(currentChar, k -> new ArrayList<>()).add(runLength);
            i = j;
        }

        int overallMaxL = -1;

        for (Map.Entry<Character, List<Integer>> entry : charRunLengths.entrySet()) {
            List<Integer> lengths = entry.getValue();
            Collections.sort(lengths, Collections.reverseOrder());

            // Case 1: At least 3 maximal consecutive runs of this character exist.
            // The length of the 3rd longest run (lengths.get(2)) is a candidate.
            // A special substring of this length will occur at least once in each of the top 3 runs,
            // thus at least 3 times in total.
            if (lengths.size() >= 3) {
                overallMaxL = Math.max(overallMaxL, lengths.get(2));
            }

            // Case 2: At least 2 maximal consecutive runs of this character exist.
            // Let L1 and L2 be the lengths of the two longest runs.
            // We want to find the maximum L such that (L1 - L + 1) + (L2 - L + 1) >= 3.
            // This simplifies to L1 + L2 + 2 - 2L >= 3
            // => L1 + L2 - 1 >= 2L
            // => L <= (L1 + L2 - 1) / 2.
            // We take the floor of this value.
            if (lengths.size() >= 2) {
                int l1 = lengths.get(0);
                int l2 = lengths.get(1);
                overallMaxL = Math.max(overallMaxL, Math.max(0, (l1 + l2 - 1) / 2));
            }

            // Case 3: At least 1 maximal consecutive run of this character exists.
            // Let L1 be the length of the longest run.
            // We want to find the maximum L such that L1 - L + 1 >= 3.
            // This simplifies to L1 - 2 >= L.
            // We take this value.
            if (lengths.size() >= 1) {
                int l1 = lengths.get(0);
                overallMaxL = Math.max(overallMaxL, Math.max(0, l1 - 2));
            }
        }

        // If overallMaxL is 0, it means no positive length special substring was found to occur thrice.
        // In this case, the problem expects -1. Otherwise, return the found max length.
        return overallMaxL == 0 ? -1 : overallMaxL;
    }
}