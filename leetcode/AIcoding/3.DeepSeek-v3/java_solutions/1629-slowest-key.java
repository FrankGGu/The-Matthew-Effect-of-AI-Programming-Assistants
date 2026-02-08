class Solution {
    public char slowestKey(int[] releaseTimes, String keysPressed) {
        int maxDuration = releaseTimes[0];
        char result = keysPressed.charAt(0);

        for (int i = 1; i < releaseTimes.length; i++) {
            int duration = releaseTimes[i] - releaseTimes[i - 1];
            if (duration > maxDuration) {
                maxDuration = duration;
                result = keysPressed.charAt(i);
            } else if (duration == maxDuration) {
                if (keysPressed.charAt(i) > result) {
                    result = keysPressed.charAt(i);
                }
            }
        }

        return result;
    }
}