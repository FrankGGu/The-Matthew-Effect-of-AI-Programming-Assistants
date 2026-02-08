import java.util.Arrays;
import java.util.Collections;

class Solution {
    public long minimumCost(int m, int n, int[] horizontalCuts, int[] verticalCuts) {
        Integer[] hCuts = new Integer[horizontalCuts.length];
        for (int i = 0; i < horizontalCuts.length; i++) {
            hCuts[i] = horizontalCuts[i];
        }
        Arrays.sort(hCuts, Collections.reverseOrder());

        Integer[] vCuts = new Integer[verticalCuts.length];
        for (int i = 0; i < verticalCuts.length; i++) {
            vCuts[i] = verticalCuts[i];
        }
        Arrays.sort(vCuts, Collections.reverseOrder());

        long totalCost = 0;
        int horizontalPieces = 1;
        int verticalPieces = 1;

        int i = 0;
        int j = 0;

        while (i < hCuts.length || j < vCuts.length) {
            if (i < hCuts.length && (j == vCuts.length || hCuts[i] >= vCuts[j])) {
                totalCost += (long) hCuts[i] * verticalPieces;
                horizontalPieces++;
                i++;
            } else { 
                totalCost += (long) vCuts[j] * horizontalPieces;
                verticalPieces++;
                j++;
            }
        }

        return totalCost;
    }
}