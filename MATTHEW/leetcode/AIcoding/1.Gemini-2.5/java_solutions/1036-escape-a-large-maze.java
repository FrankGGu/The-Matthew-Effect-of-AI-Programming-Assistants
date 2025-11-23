import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;

class Solution {
    private static final int MAX_COORD = 1_000_000;
    private static final int[][] DIRS = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public boolean isEscapePossible(int[] blocked, int[] source, int[] target) {
        if (blocked.length == 0) {
            return true;
        }

        HashSet<Long> blockedSet = new HashSet<>();
        for (int[] block : blocked) {
            blockedSet.add(block[0] * (long)MAX_COORD + block[1]);
        }

        // The maximum number of cells that can be enclosed by N blocked cells is roughly N*(N-1)/2.
        // For N=200, this is 200*199/2 = 19900.
        // If a BFS explores more cells than this, it means it has effectively escaped the "trap" formed by the blocked cells.
        // A common safe limit for the number of visited cells before declaring "escaped" is N*N, or 200*200 = 40000.
        // Using 200 * 200 as the limit for the number of cells visited.
        int limit = blocked.length * blocked.length; 
        if (limit == 0) limit = 1; // Handle case where blocked.length is 0, though already handled above.

        // Check if source can reach target or escape the blocked area.
        // Check if target can reach source or escape the blocked area.
        // Both conditions must be true for an escape to be possible.
        return bfs(source, target, blockedSet, limit) && bfs(target, source, blockedSet, limit);
    }

    private boolean bfs(int[] start, int[] target, HashSet<Long> blockedSet, int limit) {
        Queue<int[]> queue = new LinkedList<>();
        HashSet<Long> visited = new HashSet<>();

        queue.offer(start);
        visited.add(start[0] * (long)MAX_COORD + start[1]);

        int count = 0;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            count++;

            // If we have visited more cells than the limit, it means we have escaped the local blocked area.
            if (count > limit) {
                return true;
            }

            if (curr[0] == target[0] && curr[1] == target[1]) {
                return true; // Reached target
            }

            for (int[] dir : DIRS) {
                int nx = curr[0] + dir[0];
                int ny = curr[1] + dir[1];

                // Check bounds
                if (nx < 0 || nx >= MAX_COORD || ny < 0 || ny >= MAX_COORD) {
                    continue;
                }

                long nextCoord = nx * (long)MAX_COORD + ny;

                // Check if blocked or visited
                if (blockedSet.contains(nextCoord) || visited.contains(nextCoord)) {
                    continue;
                }

                visited.add(nextCoord);
                queue.offer(new int[]{nx, ny});
            }
        }

        // If the queue becomes empty and we haven't reached the target and haven't exceeded the limit,
        // it means the starting point is trapped within a small area.
        return false;
    }
}