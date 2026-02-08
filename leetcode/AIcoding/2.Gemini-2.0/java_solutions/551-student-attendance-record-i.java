class Solution {
    public boolean checkRecord(String s) {
        int absentCount = 0;
        int lateCount = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == 'A') {
                absentCount++;
                lateCount = 0;
            } else if (s.charAt(i) == 'L') {
                lateCount++;
            } else {
                lateCount = 0;
            }

            if (absentCount > 1 || lateCount > 2) {
                return false;
            }
        }
        return true;
    }
}