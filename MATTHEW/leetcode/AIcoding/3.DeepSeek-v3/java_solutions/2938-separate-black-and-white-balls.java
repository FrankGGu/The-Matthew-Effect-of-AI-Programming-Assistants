class Solution {
    public long minimumSteps(String s) {
        long steps = 0;
        int whiteCount = 0;

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '0') {
                whiteCount++;
            } else {
                steps += whiteCount;
            }
        }

        return steps;
    }
}