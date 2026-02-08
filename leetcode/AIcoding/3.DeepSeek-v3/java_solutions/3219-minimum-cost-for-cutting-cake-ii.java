import java.util.*;

class Solution {
    public int minCost(int n, int m, int[] hCuts, int[] vCuts) {
        Arrays.sort(hCuts);
        Arrays.sort(vCuts);

        int maxH = Math.max(hCuts[0], n - hCuts[hCuts.length - 1]);
        for (int i = 1; i < hCuts.length; i++) {
            maxH = Math.max(maxH, hCuts[i] - hCuts[i - 1]);
        }

        int maxV = Math.max(vCuts[0], m - vCuts[vCuts.length - 1]);
        for (int i = 1; i < vCuts.length; i++) {
            maxV = Math.max(maxV, vCuts[i] - vCuts[i - 1]);
        }

        return (int)((long)maxH * maxV % 1000000007);
    }
}