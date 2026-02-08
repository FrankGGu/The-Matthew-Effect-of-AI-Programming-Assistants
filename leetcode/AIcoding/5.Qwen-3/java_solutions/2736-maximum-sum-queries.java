public class Solution {

import java.util.*;

public class Solution {
    public int[] maximumSumQueries(int[] nums1, int[] nums2, int[][] queries) {
        int n = nums1.length;
        int m = queries.length;
        int[][] queryList = new int[m][2];
        for (int i = 0; i < m; i++) {
            queryList[i][0] = queries[i][0];
            queryList[i][1] = queries[i][1];
        }

        List<int[]> list = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            list.add(new int[]{nums1[i], nums2[i]});
        }

        list.sort((a, b) -> b[0] - a[0]);

        int[] result = new int[m];

        for (int i = 0; i < m; i++) {
            int x = queryList[i][0];
            int y = queryList[i][1];
            int maxSum = -1;
            for (int j = 0; j < n; j++) {
                if (list.get(j)[0] >= x && list.get(j)[1] >= y) {
                    maxSum = Math.max(maxSum, list.get(j)[0] + list.get(j)[1]);
                }
            }
            result[i] = maxSum;
        }

        return result;
    }
}
}