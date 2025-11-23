import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numSplits(String s) {
        int n = s.length();
        int[] leftCount = new int[n];
        int[] rightCount = new int[n];

        Set<Character> seen = new HashSet<>();

        // Populate leftCount array
        for (int i = 0; i < n; i++) {
            seen.add(s.charAt(i));
            leftCount[i] = seen.size();
        }

        seen.clear(); // Reset for rightCount

        // Populate rightCount array
        for (int i = n - 1; i >= 0; i--) {
            seen.add(s.charAt(i));
            rightCount[i] = seen.size();
        }

        int goodWays = 0;
        // Iterate through all possible split points
        // A split at index k means:
        // Left substring: s[0...k]
        // Right substring: s[k+1...n-1]
        // The loop for k goes from 0 to n-2 because the right substring must have at least one character.
        for (int k = 0; k < n - 1; k++) {
            if (leftCount[k] == rightCount[k + 1]) {
                goodWays++;
            }
        }

        return goodWays;
    }
}