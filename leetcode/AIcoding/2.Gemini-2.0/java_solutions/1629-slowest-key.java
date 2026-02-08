class Solution {
    public char slowestKey(int[] releaseTimes, String keysPressed) {
        char slowestKey = keysPressed.charAt(0);
        int maxDuration = releaseTimes[0];

        for (int i = 1; i < releaseTimes.length; i++) {
            int duration = releaseTimes[i] - releaseTimes[i - 1];
            if (duration > maxDuration) {
                maxDuration = duration;
                slowestKey = keysPressed.charAt(i);
            } else if (duration == maxDuration && keysPressed.charAt(i) > slowestKey) {
                slowestKey = keysPressed.charAt(i);
            }
        }

        return slowestKey;
    }
}