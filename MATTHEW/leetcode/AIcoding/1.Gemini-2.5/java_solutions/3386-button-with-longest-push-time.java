class Solution {
    public char slowestKey(int[] releaseTimes, String keysPressed) {
        int n = releaseTimes.length;
        int maxDuration = releaseTimes[0];
        char resultChar = keysPressed.charAt(0);

        for (int i = 1; i < n; i++) {
            int currentDuration = releaseTimes[i] - releaseTimes[i - 1];
            char currentKey = keysPressed.charAt(i);

            if (currentDuration > maxDuration) {
                maxDuration = currentDuration;
                resultChar = currentKey;
            } else if (currentDuration == maxDuration) {
                if (currentKey > resultChar) {
                    resultChar = currentKey;
                }
            }
        }
        return resultChar;
    }
}