public class Solution {

import java.util.*;

public class Solution {
    public int maxProfitAssignment(int[] skill, int[] profit, int[] worker) {
        int n = skill.length;
        int[][] jobs = new int[n][2];
        for (int i = 0; i < n; i++) {
            jobs[i][0] = skill[i];
            jobs[i][1] = profit[i];
        }
        Arrays.sort(jobs, (a, b) -> a[0] - b[0]);
        for (int i = 1; i < n; i++) {
            if (jobs[i][1] < jobs[i - 1][1]) {
                jobs[i][1] = jobs[i - 1][1];
            }
        }
        int m = worker.length;
        Arrays.sort(worker);
        int res = 0;
        int j = 0;
        for (int w : worker) {
            while (j < n && jobs[j][0] <= w) {
                j++;
            }
            if (j > 0) {
                res += jobs[j - 1][1];
            }
        }
        return res;
    }
}
}