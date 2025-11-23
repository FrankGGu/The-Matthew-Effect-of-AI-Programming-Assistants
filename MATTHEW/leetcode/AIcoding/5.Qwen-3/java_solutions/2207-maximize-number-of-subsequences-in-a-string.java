public class Solution {
    public long maximumSubsequenceCount(String s) {
        long count = 0;
        long aCount = 0;
        long bCount = 0;
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                aCount++;
            } else if (c == 'b') {
                bCount++;
            }
        }
        long total = 0;
        long current = 0;
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                current++;
            } else if (c == 'b') {
                total += current;
            }
        }
        return total + Math.max(aCount, bCount);
    }
}