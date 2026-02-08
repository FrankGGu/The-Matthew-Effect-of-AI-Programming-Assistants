import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<Boolean> canMakePalindromeQueries(String s, int[][] queries) {
        int n = s.length();
        int[] prefixMasks = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixMasks[i + 1] = prefixMasks[i] ^ (1 << (s.charAt(i) - 'a'));
        }

        List<Boolean> results = new ArrayList<>();
        for (int[] query : queries) {
            int left = query[0];
            int right = query[1];
            int k = query[2];

            int subMask = prefixMasks[right + 1] ^ prefixMasks[left];
            int oddCounts = Integer.bitCount(subMask);

            if (oddCounts / 2 <= k) {
                results.add(true);
            } else {
                results.add(false);
            }
        }
        return results;
    }
}