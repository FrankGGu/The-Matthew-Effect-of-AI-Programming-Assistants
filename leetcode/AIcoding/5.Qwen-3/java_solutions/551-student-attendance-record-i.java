public class Solution {
    public boolean checkRecord(String s) {
        int countA = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == 'A') {
                countA++;
                if (countA >= 2) {
                    return false;
                }
            } else if (i > 0 && s.charAt(i) == 'L' && s.charAt(i - 1) == 'L' && i < s.length() - 1 && s.charAt(i + 1) == 'L') {
                return false;
            }
        }
        return true;
    }
}