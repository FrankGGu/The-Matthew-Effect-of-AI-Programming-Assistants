public class Solution {

import java.util.Arrays;

public class Solution {
    public int maxSatisfaction(int[] satisfaction) {
        Arrays.sort(satisfaction);
        int n = satisfaction.length;
        int total = 0;
        int res = 0;
        for (int i = n - 1; i >= 0; i--) {
            total += satisfaction[i];
            if (total > 0) {
                res += total;
            } else {
                break;
            }
        }
        return res;
    }
}
}