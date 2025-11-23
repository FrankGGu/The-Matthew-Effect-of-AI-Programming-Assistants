class Solution {
    public int minSwaps(int[] data) {
        int onesCount = 0;
        for (int num : data) {
            if (num == 1) onesCount++;
        }

        int maxOnesInWindow = 0;
        int windowOnes = 0;
        for (int i = 0; i < data.length; i++) {
            if (data[i] == 1) windowOnes++;
            if (i >= onesCount) {
                windowOnes -= data[i - onesCount];
            }
            if (i >= onesCount - 1) {
                maxOnesInWindow = Math.max(maxOnesInWindow, windowOnes);
            }
        }

        return onesCount - maxOnesInWindow;
    }
}