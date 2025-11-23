import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int longestSpecialSubstring(String s) {
        Map<Character, List<Integer>> charRuns = new HashMap<>();

        int n = s.length();
        int i = 0;
        while (i < n) {
            char currentChar = s.charAt(i);
            int count = 0;
            int j = i;
            while (j < n && s.charAt(j) == currentChar) {
                count++;
                j++;
            }
            charRuns.computeIfAbsent(currentChar, k -> new ArrayList<>()).add(count);
            i = j;
        }

        int maxK = -1;

        for (List<Integer> lengths : charRuns.values()) {
            Collections.sort(lengths, Collections.reverseOrder());

            // Case 1: Consider only the longest run (l1)
            // A run of length L contributes (L - k + 1) occurrences of a substring of length k.
            // To have at least 3 occurrences from a single run: (l1 - k + 1) >= 3  =>  k <= l1 - 2
            // The maximum k from this scenario is l1 - 2.
            int l1 = lengths.get(0);
            if (l1 >= 3) { // k must be at least 1, so l1 - 2 >= 1 => l1 >= 3
                maxK = Math.max(maxK, l1 - 2);
            }

            // Case 2: Consider the two longest runs (l1 and l2)
            // If k is such that both l1 and l2 can form it (i.e., k <= l2),
            // then total occurrences = (l1 - k + 1) + (l2 - k + 1).
            // We need this sum to be at least 3: l1 + l2 - 2k + 2 >= 3  =>  2k <= l1 + l2 - 1  =>  k <= (l1 + l2 - 1) / 2.
            // Also, k must be <= l2 for both runs to contribute.
            if (lengths.size() >= 2) {
                int l2 = lengths.get(1);
                int kCandidate = (l1 + l2 - 1) / 2;
                // The actual k must be <= l2 to ensure both runs contribute.
                // If kCandidate is greater than l2, it means we can't get 3 occurrences by combining l1 and l2 where both contribute.
                // The max k for this scenario is min(l2, kCandidate).
                if (kCandidate >= 1) { // k must be at least 1
                    maxK = Math.max(maxK, Math.min(l2, kCandidate));
                }
            }

            // Case 3: Consider the three longest runs (l1, l2, and l3)
            // If k is such that l1, l2, and l3 can all form it (i.e., k <= l3),
            // then total occurrences = (l1 - k + 1) + (l2 - k + 1) + (l3 - k + 1).
            // We need this sum to be at least 3: l1 + l2 + l3 - 3k + 3 >= 3  =>  3k <= l1 + l2 + l3  =>  k <= (l1 + l2 + l3) / 3.
            // Also, k must be <= l3 for all three runs to contribute.
            if (lengths.size() >= 3) {
                int l3 = lengths.get(2);
                int kCandidate = (l1 + l2 + l3) / 3;
                // The actual k must be <= l3 to ensure all three runs contribute.
                if (kCandidate >= 1) { // k must be at least 1
                    maxK = Math.max(maxK, Math.min(l3, kCandidate));
                }
            }
        }

        return maxK;
    }
}