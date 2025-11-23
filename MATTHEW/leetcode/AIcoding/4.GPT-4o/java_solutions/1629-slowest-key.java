class Solution {
    public char slowestKey(int[] releaseTimes, String keysPressed) {
        char result = keysPressed.charAt(0);
        int maxDuration = releaseTimes[0];

        for (int i = 1; i < releaseTimes.length; i++) {
            int duration = releaseTimes[i] - releaseTimes[i - 1];
            if (duration > maxDuration || (duration == maxDuration && keysPressed.charAt(i) > result)) {
                maxDuration = duration;
                result = keysPressed.charAt(i);
            }
        }
        return result;
    }
}