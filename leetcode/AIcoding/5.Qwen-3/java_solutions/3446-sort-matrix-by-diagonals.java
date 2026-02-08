public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> diagonalSort(List<List<Integer>> matrix) {
        int m = matrix.size();
        int n = matrix.get(0).size();
        Map<Integer, PriorityQueue<Integer>> map = new HashMap<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int key = i - j;
                map.putIfAbsent(key, new PriorityQueue<>());
                map.get(key).add(matrix.get(i).get(j));
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int key = i - j;
                matrix.get(i).set(j, map.get(key).poll());
            }
        }

        return matrix;
    }
}
}