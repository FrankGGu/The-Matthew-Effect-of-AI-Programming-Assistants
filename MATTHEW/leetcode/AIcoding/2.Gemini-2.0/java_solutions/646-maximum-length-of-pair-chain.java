import java.util.Arrays;

class Solution {
    public int findLongestChain(int[][] pairs) {
        Arrays.sort(pairs, (a, b) -> a[1] - b[1]);
        int chainLength = 0;
        int currentEnd = Integer.MIN_VALUE;
        for (int[] pair : pairs) {
            if (pair[0] > currentEnd) {
                chainLength++;
                currentEnd = pair[1];
            }
        }
        return chainLength;
    }
}