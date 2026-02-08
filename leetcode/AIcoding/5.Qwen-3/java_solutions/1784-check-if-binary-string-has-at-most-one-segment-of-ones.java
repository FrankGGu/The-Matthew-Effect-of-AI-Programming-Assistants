public class Solution {
    public boolean checkIfOneSegment(String s) {
        boolean foundOne = false;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                foundOne = true;
            } else if (foundOne) {
                return false;
            }
        }
        return true;
    }
}