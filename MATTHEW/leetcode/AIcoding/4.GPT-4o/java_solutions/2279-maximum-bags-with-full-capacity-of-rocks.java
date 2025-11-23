import java.util.Arrays;

class Solution {
    public int maxBags(int[] capacity, int[] rocks, int additionalRocks) {
        int n = capacity.length;
        int[] spaceLeft = new int[n];

        for (int i = 0; i < n; i++) {
            spaceLeft[i] = capacity[i] - rocks[i];
        }

        Arrays.sort(spaceLeft);

        int count = 0;
        for (int space : spaceLeft) {
            if (additionalRocks >= space) {
                additionalRocks -= space;
                count++;
            } else {
                break;
            }
        }

        return count;
    }
}