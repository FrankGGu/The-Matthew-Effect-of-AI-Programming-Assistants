import java.util.*;

public class Solution {
    public int minimumReverseOperations(int n, int p, int[] banned, int k) {
        Set<Integer> bannedSet = new HashSet<>();
        for (int b : banned) {
            bannedSet.add(b);
        }

        boolean[] visited = new boolean[n];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{p, 0});
        visited[p] = true;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int pos = curr[0];
            int steps = curr[1];

            if (pos == 0) return steps;

            for (int i = 0; i < k; i++) {
                int newPos = pos - i + (k - 1 - i);
                if (newPos >= 0 && newPos < n && !bannedSet.contains(newPos) && !visited[newPos]) {
                    visited[newPos] = true;
                    queue.offer(new int[]{newPos, steps + 1});
                }
            }
        }
        return -1;
    }
}