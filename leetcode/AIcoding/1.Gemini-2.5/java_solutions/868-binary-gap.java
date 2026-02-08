class Solution {
    public int binaryGap(int n) {
        int lastOneIndex = -1;
        int maxGap = 0;
        int currentBitIndex = 0;

        while (n > 0) {
            if ((n & 1) == 1) {
                if (lastOneIndex != -1) {
                    maxGap = Math.max(maxGap, currentBitIndex - lastOneIndex);
                }
                lastOneIndex = currentBitIndex;
            }
            n >>= 1;
            currentBitIndex++;
        }

        return maxGap;
    }
}