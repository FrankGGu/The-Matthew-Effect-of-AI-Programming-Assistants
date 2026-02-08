class Solution {
    public int minimumSteps(String s) {
        int steps = 0;
        int whiteCount = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '0') {
                steps += whiteCount;
            } else {
                whiteCount++;
            }
        }
        return steps;
    }
}