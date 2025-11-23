public class Solution {

import java.util.*;

public class Solution {
    public int minTimeToCollectFruits(int[][] fruits, int capacity1, int capacity2) {
        int n = fruits.length;
        int[] time1 = new int[n];
        int[] time2 = new int[n];

        for (int i = 0; i < n; i++) {
            time1[i] = fruits[i][0] * 2;
            time2[i] = fruits[i][1] * 2;
        }

        Arrays.sort(time1);
        Arrays.sort(time2);

        int sum1 = 0;
        int sum2 = 0;
        int i = 0;
        while (i < n && sum1 + time1[i] <= capacity1) {
            sum1 += time1[i];
            i++;
        }

        int j = 0;
        while (j < n && sum2 + time2[j] <= capacity2) {
            sum2 += time2[j];
            j++;
        }

        if (i + j < n) {
            return -1;
        }

        return Math.max(sum1, sum2);
    }
}
}