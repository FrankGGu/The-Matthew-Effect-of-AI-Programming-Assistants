public class Solution {

import java.util.*;

public class Solution {
    int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    Set<String> visited = new HashSet<>();
    Set<String> targetSet = new HashSet<>();

    public boolean isEscapePossible(int[][] blocked, int[][] userLocation, int[][] target) {
        Set<String> blockSet = new HashSet<>();
        for (int[] b : blocked) {
            blockSet.add(b[0] + "," + b[1]);
        }
        boolean userToTarget = bfs(userLocation, target, blockSet, false);
        boolean targetToUser = bfs(target, userLocation, blockSet, true);
        return userToTarget && targetToUser;
    }

    private boolean bfs(int[] start, int[] end, Set<String> blockSet, boolean isTarget) {
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(start);
        visited.clear();
        String startStr = start[0] + "," + start[1];
        visited.add(startStr);
        int count = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                if (isTarget && curr[0] == end[0] && curr[1] == end[1]) {
                    return true;
                }
                if (!isTarget && curr[0] == end[0] && curr[1] == end[1]) {
                    return true;
                }
                for (int[] dir : dirs) {
                    int x = curr[0] + dir[0];
                    int y = curr[1] + dir[1];
                    String key = x + "," + y;
                    if (x >= 0 && y >= 0 && x < 1000000 && y < 1000000 && !blockSet.contains(key) && !visited.contains(key)) {
                        visited.add(key);
                        queue.offer(new int[]{x, y});
                    }
                }
            }
            count++;
            if (count > 2 * blockSet.size()) {
                return true;
            }
        }
        return false;
    }
}
}