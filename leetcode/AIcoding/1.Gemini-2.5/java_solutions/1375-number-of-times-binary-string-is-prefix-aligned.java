class Solution {
    public int numTimesAllBlue(int[] flips) {
        int alignedTimes = 0;
        int maxOn = 0;

        for (int i = 0; i < flips.length; i++) {
            maxOn = Math.max(maxOn, flips[i]);
            if (maxOn == (i + 1)) {
                alignedTimes++;
            }
        }

        return alignedTimes;
    }
}