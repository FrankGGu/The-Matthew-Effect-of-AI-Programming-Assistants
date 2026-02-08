class Solution {
    public int longestPress(int[] releaseTimes, String pressedKeys) {
        int longest = releaseTimes[0];
        int index = 0;
        for (int i = 1; i < releaseTimes.length; i++) {
            if (releaseTimes[i] - releaseTimes[i - 1] > longest) {
                longest = releaseTimes[i] - releaseTimes[i - 1];
                index = i;
            } else if (releaseTimes[i] - releaseTimes[i - 1] == longest) {
                if (pressedKeys.charAt(i) < pressedKeys.charAt(index)) {
                    index = i;
                }
            }
        }
        return pressedKeys.charAt(index) - 'a';
    }
}