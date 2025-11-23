class Solution {
    public boolean checkRecord(String s) {
        int absentCount = 0;
        for (char c : s.toCharArray()) {
            if (c == 'A') {
                absentCount++;
            }
        }

        if (absentCount > 1) {
            return false;
        }

        if (s.contains("LLL")) {
            return false;
        }

        return true;
    }
}