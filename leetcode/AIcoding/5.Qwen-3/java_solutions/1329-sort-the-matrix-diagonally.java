public class Solution {

import java.util.*;

public class Solution {
    public int[][] diagonalSort(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;
        Map<Integer, PriorityQueue<Integer>> map = new HashMap<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int key = i - j;
                map.putIfAbsent(key, new PriorityQueue<>());
                map.get(key).add(matrix[i][j]);
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int key = i - j;
                matrix[i][j] = map.get(key).poll();
            }
        }

        return matrix;
    }
}
}