class Solution {
    public int minFlipsMonoIncr(String s) {
        int flips = 0, ones = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                ones++;
            } else {
                flips++;
            }
            flips = Math.min(flips, ones);
        }
        return flips;
    }
}