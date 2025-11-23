public class Solution {

import java.util.*;

public class Solution {
    public int maxActiveSections(int[] trade, int[] duration) {
        int n = trade.length;
        int[] start = new int[n];
        int[] end = new int[n];

        for (int i = 0; i < n; i++) {
            start[i] = trade[i];
            end[i] = trade[i] + duration[i] - 1;
        }

        Arrays.sort(start);
        Arrays.sort(end);

        int res = 0;
        int i = 0, j = 0;
        while (i < n) {
            if (start[i] <= end[j]) {
                res++;
                i++;
            } else {
                j++;
            }
        }

        return res;
    }
}
}