class Solution {
    public int longestButtonPress(String sequence) {
        int maxTime = 0;
        int currentTime = 0;
        char prevChar = ' ';

        for (char c : sequence.toCharArray()) {
            if (c == prevChar) {
                currentTime++;
            } else {
                currentTime = 1;
                prevChar = c;
            }
            maxTime = Math.max(maxTime, currentTime);
        }

        return maxTime;
    }
}