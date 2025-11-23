import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

class Solution {
    public boolean isEscapePossible(int[][] blocked, int[] source, int[] target) {
        Set<String> blockedSet = new HashSet<>();
        for (int[] block : blocked) {
            blockedSet.add(block[0] + "," + block[1]);
        }

        return isReachable(source, target, blockedSet, blocked.length) &&
               isReachable(target, source, blockedSet, blocked.length);
    }

    private boolean isReachable(int[] start, int[] end, Set<String> blockedSet, int blockedLength) {
        Set<String> visited = new HashSet<>();
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(start);
        visited.add(start[0] + "," + start[1]);

        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
        int maxReachable = blockedLength * (blockedLength - 1) / 2;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            if (curr[0] == end[0] && curr[1] == end[1]) {
                return true;
            }

            if (visited.size() > maxReachable) {
                return true;
            }

            for (int[] dir : directions) {
                int newRow = curr[0] + dir[0];
                int newCol = curr[1] + dir[1];

                if (newRow >= 0 && newRow < 1000000 && newCol >= 0 && newCol < 1000000) {
                    String next = newRow + "," + newCol;
                    if (!blockedSet.contains(next) && !visited.contains(next)) {
                        queue.offer(new int[]{newRow, newCol});
                        visited.add(next);
                    }
                }
            }
        }

        return false;
    }
}