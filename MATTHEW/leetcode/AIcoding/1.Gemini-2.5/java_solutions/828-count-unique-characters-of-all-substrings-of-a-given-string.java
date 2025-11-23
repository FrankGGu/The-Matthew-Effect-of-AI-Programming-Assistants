import java.util.ArrayList;
import java.util.List;

class Solution {
    public int uniqueLetterString(String s) {
        int n = s.length();

        // positions[c] will store a list of indices where character 'c' appears.
        // We add -1 at the beginning and n at the end as sentinels.
        // This simplifies calculation of (i - prev) and (next - i).
        List<Integer>[] positions = new ArrayList[26];
        for (int i = 0; i < 26; i++) {
            positions[i] = new ArrayList<>();
            positions[i].add(-1); // Sentinel for previous occurrence
        }

        for (int i = 0; i < n; i++) {
            positions[s.charAt(i) - 'A'].add(i);
        }

        for (int i = 0; i < 26; i++) {
            positions[i].add(n); // Sentinel for next occurrence
        }

        long totalCount = 0;

        // Iterate through each character 'c' from 'A' to 'Z'
        for (int i = 0; i < 26; i++) {
            List<Integer> charPositions = positions[i];
            // Iterate through the actual occurrences of character 'c'
            // The list has sentinels at index 0 and charPositions.size() - 1.
            // So, actual occurrences are from index 1 to charPositions.size() - 2.
            for (int j = 1; j < charPositions.size() - 1; j++) {
                int currentIdx = charPositions.get(j);
                int prevIdx = charPositions.get(j - 1);
                int nextIdx = charPositions.get(j + 1);

                // For the character at currentIdx, it can be the unique character
                // in substrings starting from prevIdx + 1 up to currentIdx,
                // and ending from currentIdx up to nextIdx - 1.
                // Number of choices for the start position (L): currentIdx - prevIdx
                // Number of choices for the end position (R): nextIdx - currentIdx
                totalCount += (long) (currentIdx - prevIdx) * (nextIdx - currentIdx);
            }
        }

        return (int) totalCount;
    }
}