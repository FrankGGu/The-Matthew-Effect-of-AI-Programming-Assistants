public class Solution {
    public int countAsterisks(String s) {
        int count = 0;
        boolean inVerticalBar = false;
        for (char c : s.toCharArray()) {
            if (c == '|') {
                inVerticalBar = !inVerticalBar;
            } else if (!inVerticalBar && c == '*') {
                count++;
            }
        }
        return count;
    }
}