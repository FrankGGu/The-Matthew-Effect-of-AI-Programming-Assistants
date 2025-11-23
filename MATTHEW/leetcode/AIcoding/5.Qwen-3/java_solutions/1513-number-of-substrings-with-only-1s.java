public class Solution {
    public int numSubstrings(String s) {
        int count = 0;
        int consecutiveOnes = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                consecutiveOnes++;
                count += consecutiveOnes;
            } else {
                consecutiveOnes = 0;
            }
        }
        return count;
    }
}