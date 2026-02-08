import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public String[] shortestUncommonSubstrings(String[] arr) {
        int n = arr.length;
        String[] results = new String[n];

        // Step 1: Pre-compute all substrings for each string in arr
        // This list will store a set of all substrings for each string in arr.
        // allSubstringsOfEachString.get(k) will contain all substrings of arr[k].
        List<Set<String>> allSubstringsOfEachString = new ArrayList<>();
        for (String s : arr) {
            Set<String> currentStringSubstrings = new HashSet<>();
            for (int i = 0; i < s.length(); i++) {
                for (int j = i + 1; j <= s.length(); j++) {
                    currentStringSubstrings.add(s.substring(i, j));
                }
            }
            allSubstringsOfEachString.add(currentStringSubstrings);
        }

        // Step 2: For each string, find its shortest uncommon substring
        for (int i = 0; i < n; i++) {
            String currentString = arr[i];
            String shortestUncommon = ""; // Stores the final result for arr[i]

            // Iterate through possible substring lengths, from 1 up to currentString's length
            // We iterate by length first to ensure we find the shortest possible uncommon substring.
            for (int len = 1; len <= currentString.length(); len++) {
                String bestSubOfCurrentLength = ""; // Stores the lexicographically smallest uncommon substring of 'len'
                boolean foundUncommonOfCurrentLength = false;

                // Iterate through all possible start positions for substrings of 'len'
                for (int start = 0; start <= currentString.length() - len; start++) {
                    String sub = currentString.substring(start, start + len);

                    boolean isUncommon = true;
                    // Check if 'sub' is a substring of any other string in arr (arr[j] where j != i)
                    for (int j = 0; j < n; j++) {
                        if (i == j) {
                            continue; // Don't compare with the string itself
                        }
                        // Efficiently check if arr[j] contains 'sub' using the pre-computed set
                        if (allSubstringsOfEachString.get(j).contains(sub)) {
                            isUncommon = false;
                            break; // 'sub' is common, no need to check further strings
                        }
                    }

                    if (isUncommon) {
                        foundUncommonOfCurrentLength = true;
                        // If this is the first uncommon substring of current length, or it's lexicographically smaller
                        if (bestSubOfCurrentLength.isEmpty() || sub.compareTo(bestSubOfCurrentLength) < 0) {
                            bestSubOfCurrentLength = sub;
                        }
                    }
                }

                // If we found at least one uncommon substring of the current length 'len',
                // then 'bestSubOfCurrentLength' holds the lexicographically smallest among them.
                // Since we are iterating lengths in increasing order, this is the shortest possible
                // uncommon substring for currentString.
                if (foundUncommonOfCurrentLength) {
                    shortestUncommon = bestSubOfCurrentLength;
                    break; // Found the shortest uncommon substring for arr[i], move to the next string in arr
                }
            }
            results[i] = shortestUncommon;
        }

        return results;
    }
}