class Solution {
    public int binaryGap(int n) {
        int maxGap = 0;
        int lastOne = -1;
        for (int i = 0; i < 32; i++) {
            if (((n >> i) & 1) == 1) {
                if (lastOne != -1) {
                    maxGap = Math.max(maxGap, i - lastOne);
                }
                lastOne = i;
            }
        }
        return maxGap;
    }
}