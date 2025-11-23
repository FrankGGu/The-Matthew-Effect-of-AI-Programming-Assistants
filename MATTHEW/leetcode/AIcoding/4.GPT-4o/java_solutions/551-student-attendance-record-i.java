public class Solution {
    public boolean checkRecord(String s) {
        int aCount = 0;
        int lCount = 0;

        for (char c : s.toCharArray()) {
            if (c == 'A') {
                aCount++;
                if (aCount > 1) return false;
            }
            if (c == 'L') {
                lCount++;
                if (lCount > 2) return false;
            } else {
                lCount = 0;
            }
        }
        return true;
    }
}