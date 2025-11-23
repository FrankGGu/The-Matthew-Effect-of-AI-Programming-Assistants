public class Solution {
    public int binaryGap(int n) {
        int maxDistance = 0;
        int lastPosition = -1;

        for (int i = 0; i < 32; i++) {
            if ((n & (1 << i)) != 0) {
                if (lastPosition != -1) {
                    maxDistance = Math.max(maxDistance, i - lastPosition);
                }
                lastPosition = i;
            }
        }

        return maxDistance;
    }
}