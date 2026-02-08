import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[][] substringXorQueries(String s, int[][] queries) {
        int n = s.length();
        Map<Integer, int[]> bestSubstring = new HashMap<>();
        // Maximum length for a binary string to represent an int value (up to 2^31 - 1).
        // A 31-bit number can be represented by a string of length 31.
        int MAX_CONSIDER_LEN = 31; 

        for (int i = 0; i < n; i++) {
            long currentValue = 0;
            // Iterate through possible ending positions for substrings starting at i.
            // Limit the length to MAX_CONSIDER_LEN because any longer substring
            // would exceed Integer.MAX_VALUE if it starts with '1', or would be
            // a longer representation of a smaller number if it starts with '0'.
            for (int j = i; j < Math.min(n, i + MAX_CONSIDER_LEN); j++) {
                currentValue = currentValue * 2 + (s.charAt(j) - '0');

                // If currentValue exceeds Integer.MAX_VALUE, it cannot be a target value
                // (since target is an int). Further extending this substring will also
                // exceed Integer.MAX_VALUE, so we can stop for this starting 'i'.
                if (currentValue > Integer.MAX_VALUE) {
                    break; 
                }

                int val = (int) currentValue;
                int length = j - i + 1;

                // Store the substring with the smallest length, then smallest starting index.
                if (bestSubstring.containsKey(val)) {
                    int[] existing = bestSubstring.get(val);
                    int existingLength = existing[1] - existing[0] + 1;
                    if (length < existingLength) {
                        bestSubstring.put(val, new int[]{i, j});
                    } else if (length == existingLength && i < existing[0]) {
                        bestSubstring.put(val, new int[]{i, j});
                    }
                } else {
                    bestSubstring.put(val, new int[]{i, j});
                }
            }
        }

        int[][] results = new int[queries.length][2];
        for (int k = 0; k < queries.length; k++) {
            int first = queries[k][0];
            int second = queries[k][1];
            int target = first ^ second;

            if (bestSubstring.containsKey(target)) {
                results[k] = bestSubstring.get(target);
            } else {
                results[k] = new int[]{-1, -1};
            }
        }

        return results;
    }
}