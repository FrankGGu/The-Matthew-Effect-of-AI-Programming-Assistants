public class Solution {

import java.util.*;

public class Solution {
    public int[] arrayRankTransform(int[][] arr) {
        int m = arr.length;
        int n = arr[0].length;
        int[] result = new int[m * n];
        Map<Integer, Integer> rankMap = new HashMap<>();
        List<int[]> list = new ArrayList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                list.add(new int[]{arr[i][j], i, j});
            }
        }

        list.sort((a, b) -> a[0] - b[0]);

        int rank = 1;
        for (int i = 0; i < list.size(); i++) {
            if (i > 0 && list.get(i)[0] != list.get(i - 1)[0]) {
                rank++;
            }
            rankMap.put(list.get(i)[0], rank);
        }

        for (int i = 0; i < list.size(); i++) {
            int val = list.get(i)[0];
            int row = list.get(i)[1];
            int col = list.get(i)[2];
            result[row * n + col] = rankMap.get(val);
        }

        return result;
    }
}
}