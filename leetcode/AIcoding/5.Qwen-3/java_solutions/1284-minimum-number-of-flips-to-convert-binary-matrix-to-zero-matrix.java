public class Solution {

import java.util.*;

public class Solution {
    public int minFlips(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;
        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {0, 0}};
        Set<String> visited = new HashSet<>();
        Queue<int[]> queue = new LinkedList<>();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                sb.append(matrix[i][j]);
            }
        }
        String start = sb.toString();
        queue.add(new int[]{0, 0});
        visited.add(start);
        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int k = 0; k < size; k++) {
                int[] pos = queue.poll();
                int i = pos[0];
                int j = pos[1];
                String current = getMatrixString(matrix, m, n);
                if (isZeroMatrix(current)) {
                    return steps;
                }
                for (int[] dir : dirs) {
                    int ni = i + dir[0];
                    int nj = j + dir[1];
                    if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                        flip(matrix, ni, nj);
                        String next = getMatrixString(matrix, m, n);
                        if (!visited.contains(next)) {
                            visited.add(next);
                            queue.add(new int[]{ni, nj});
                        }
                        flip(matrix, ni, nj);
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    private void flip(int[][] matrix, int i, int j) {
        matrix[i][j] ^= 1;
    }

    private String getMatrixString(int[][] matrix, int m, int n) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                sb.append(matrix[i][j]);
            }
        }
        return sb.toString();
    }

    private boolean isZeroMatrix(String s) {
        for (char c : s.toCharArray()) {
            if (c != '0') {
                return false;
            }
        }
        return true;
    }
}
}