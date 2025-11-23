public class Solution {

import java.util.*;

public class Solution {
    public int slidingPuzzle(int[][] board) {
        String target = "123456780";
        String start = "";
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                start += board[i][j];
            }
        }

        int[][] neighbors = {
            {1, 3},
            {0, 2, 4},
            {1, 5},
            {0, 4},
            {1, 3, 5},
            {2, 4}
        };

        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();

        queue.add(start);
        visited.add(start);

        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(target)) {
                    return steps;
                }
                int index = current.indexOf('0');
                for (int neighbor : neighbors[index]) {
                    char[] arr = current.toCharArray();
                    char temp = arr[index];
                    arr[index] = arr[neighbor];
                    arr[neighbor] = temp;
                    String next = new String(arr);
                    if (!visited.contains(next)) {
                        visited.add(next);
                        queue.add(next);
                    }
                }
            }
            steps++;
        }

        return -1;
    }
}
}