class Solution {
    public int binaryGap(int n) {
        int lastIndex = -1, maxGap = 0;
        for (int i = 0; i < 32; i++) {
            if ((n & (1 << i)) != 0) {
                if (lastIndex != -1) {
                    maxGap = Math.max(maxGap, i - lastIndex);
                }
                lastIndex = i;
            }
        }
        return maxGap;
    }
}