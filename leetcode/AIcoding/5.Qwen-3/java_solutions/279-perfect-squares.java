public class Solution {

import java.util.*;

public class Solution {
    public int numSquares(int n) {
        List<Integer> squares = new ArrayList<>();
        int i = 1;
        while (i * i <= n) {
            squares.add(i * i);
            i++;
        }

        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visited = new HashSet<>();

        queue.offer(n);
        visited.add(n);

        int level = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int j = 0; j < size; j++) {
                int current = queue.poll();
                if (current == 0) {
                    return level;
                }
                for (int square : squares) {
                    int next = current - square;
                    if (next >= 0 && !visited.contains(next)) {
                        visited.add(next);
                        queue.offer(next);
                    }
                }
            }
            level++;
        }

        return level;
    }
}
}