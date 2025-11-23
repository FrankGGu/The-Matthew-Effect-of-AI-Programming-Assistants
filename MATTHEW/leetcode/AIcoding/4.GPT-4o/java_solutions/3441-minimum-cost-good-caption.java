import java.util.Arrays;

public class Solution {
    public int minimumCost(String caption, int[] cost) {
        int n = caption.length();
        int totalCost = 0;
        for (int i = 0; i < n; i++) {
            if (caption.charAt(i) == ' ') {
                continue;
            }
            totalCost += cost[caption.charAt(i) - 'a'];
        }
        return totalCost;
    }
}