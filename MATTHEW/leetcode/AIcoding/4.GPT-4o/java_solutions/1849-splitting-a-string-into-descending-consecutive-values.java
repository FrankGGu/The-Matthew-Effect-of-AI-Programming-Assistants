class Solution {
    public boolean canSplitString(String s) {
        for (int i = 1; i < s.length(); i++) {
            if (split(s, i)) {
                return true;
            }
        }
        return false;
    }

    private boolean split(String s, int start) {
        long prev = Long.parseLong(s.substring(0, start));
        for (int i = start; i < s.length(); ) {
            long curr = 0;
            while (i < s.length() && curr < prev - 1) {
                curr = curr * 10 + (s.charAt(i) - '0');
                i++;
            }
            if (curr >= prev) {
                return false;
            }
            prev = curr;
        }
        return true;
    }
}