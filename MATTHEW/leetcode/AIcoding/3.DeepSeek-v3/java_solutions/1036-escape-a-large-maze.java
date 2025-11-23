import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

class Solution {
    private static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    private static final int LIMIT = (int)1e6;

    public boolean isEscapePossible(int[][] blocked, int[] source, int[] target) {
        Set<String> blockedSet = new HashSet<>();
        for (int[] block : blocked) {
            blockedSet.add(block[0] + "," + block[1]);
        }
        return bfs(source, target, blockedSet) && bfs(target, source, blockedSet);
    }

    private boolean bfs(int[] source, int[] target, Set<String> blockedSet) {
        Set<String> visited = new HashSet<>();
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(source);
        visited.add(source[0] + "," + source[1]);
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                if (curr[0] == target[0] && curr[1] == target[1]) {
                    return true;
                }
                for (int[] dir : dirs) {
                    int x = curr[0] + dir[0];
                    int y = curr[1] + dir[1];
                    String key = x + "," + y;
                    if (x >= 0 && x < LIMIT && y >= 0 && y < LIMIT && !blockedSet.contains(key) && !visited.contains(key)) {
                        visited.add(key);
                        queue.offer(new int[]{x, y});
                    }
                }
            }
            steps++;
            if (steps == 200) {
                break;
            }
        }
        return steps == 200;
    }
}