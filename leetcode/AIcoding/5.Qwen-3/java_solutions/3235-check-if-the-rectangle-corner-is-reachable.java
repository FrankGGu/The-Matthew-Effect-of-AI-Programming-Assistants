public class Solution {

import java.util.*;

public class Solution {
    public boolean isReachable(int[] start, int[] target, int[][] specialPoints) {
        Set<String> visited = new HashSet<>();
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(start);
        visited.add(start[0] + "," + start[1]);

        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            if (current[0] == target[0] && current[1] == target[1]) {
                return true;
            }
            for (int[] dir : directions) {
                int x = current[0] + dir[0];
                int y = current[1] + dir[1];
                String key = x + "," + y;
                if (!visited.contains(key)) {
                    boolean isSpecial = false;
                    for (int[] sp : specialPoints) {
                        if (sp[0] == x && sp[1] == y) {
                            isSpecial = true;
                            break;
                        }
                    }
                    if (!isSpecial) {
                        visited.add(key);
                        queue.offer(new int[]{x, y});
                    }
                }
            }
        }
        return false;
    }
}
}