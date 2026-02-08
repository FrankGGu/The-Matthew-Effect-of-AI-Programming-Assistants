public class Solution {

import java.util.*;

public class Solution {
    public String substringWithMaxCost(String s, int k) {
        int n = s.length();
        int[] cost = new int[n];
        for (int i = 0; i < n; i++) {
            cost[i] = s.charAt(i) - 'a' + 1;
        }

        int maxCost = 0;
        int start = 0;
        int currentCost = 0;

        for (int i = 0; i < n; i++) {
            currentCost += cost[i];

            if (i >= k) {
                currentCost -= cost[i - k];
                start = i - k + 1;
            }

            if (i >= k - 1) {
                if (currentCost > maxCost) {
                    maxCost = currentCost;
                }
            }
        }

        return s.substring(start, start + k);
    }
}
}