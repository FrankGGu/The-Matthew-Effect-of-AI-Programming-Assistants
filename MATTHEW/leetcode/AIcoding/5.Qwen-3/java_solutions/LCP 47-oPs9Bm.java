public class Solution {

import java.util.*;

public class Solution {
    public int[] entranceSecurity(int[] time, int[] weight) {
        int n = time.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = 0; j <= i; j++) {
                if (time[j] >= time[i] - 60 && time[j] <= time[i] && weight[j] >= 50 && weight[j] <= 150) {
                    count++;
                }
            }
            result[i] = count;
        }
        return result;
    }
}
}