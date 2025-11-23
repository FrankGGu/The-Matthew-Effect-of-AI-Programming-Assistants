class Solution {
    public char slowestKey(int[][] keyTimes) {
        int maxDuration = keyTimes[0][1];
        char slowestKeyChar = (char) ('a' + keyTimes[0][0]);

        for (int i = 1; i < keyTimes.length; i++) {
            int currentDuration = keyTimes[i][1] - keyTimes[i - 1][1];
            char currentKeyChar = (char) ('a' + keyTimes[i][0]);

            if (currentDuration > maxDuration) {
                maxDuration = currentDuration;
                slowestKeyChar = currentKeyChar;
            } else if (currentDuration == maxDuration) {
                if (currentKeyChar > slowestKeyChar) {
                    slowestKeyChar = currentKeyChar;
                }
            }
        }

        return slowestKeyChar;
    }
}