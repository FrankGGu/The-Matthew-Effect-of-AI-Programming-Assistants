import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int longestSpecialSubstring(String s) {
        Map<Character, List<Integer>> charRunLengths = new HashMap<>();

        int n = s.length();
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

        int low = 1;
        int high = n;
        int ans = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, charRunLengths)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }

    private boolean check(int k, Map<Character, List<Integer>> charRunLengths) {
        int totalOccurrences = 0;
        for (List<Integer> runs : charRunLengths.values()) {
            for (int runLength : runs) {
                if (runLength >= k) {
                    totalOccurrences += (runLength - k + 1);
                }
            }
        }
        return totalOccurrences >= 3;
    }
}