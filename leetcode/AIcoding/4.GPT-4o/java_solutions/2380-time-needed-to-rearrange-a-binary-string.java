class Solution {
    public int minTimeToRearrange(String s) {
        int n = s.length();
        int ones = 0, zeros = 0;

        for (char c : s.toCharArray()) {
            if (c == '1') ones++;
            else zeros++;
        }

        return Math.max(ones, zeros);
    }
}