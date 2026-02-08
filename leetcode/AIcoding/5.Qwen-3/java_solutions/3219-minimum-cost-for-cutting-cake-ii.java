public class Solution {

import java.util.*;

public class Solution {
    public int minCost(int n, int m, int[] hBars, int[] vBars) {
        Arrays.sort(hBars);
        Arrays.sort(vBars);

        int maxH = 0, currentH = 1;
        for (int i = 1; i < hBars.length; i++) {
            if (hBars[i] == hBars[i - 1] + 1) {
                currentH++;
                maxH = Math.max(maxH, currentH);
            } else {
                currentH = 1;
            }
        }

        int maxV = 0, currentV = 1;
        for (int i = 1; i < vBars.length; i++) {
            if (vBars[i] == vBars[i - 1] + 1) {
                currentV++;
                maxV = Math.max(maxV, currentV);
            } else {
                currentV = 1;
            }
        }

        return (maxH + 1) * (maxV + 1);
    }
}
}