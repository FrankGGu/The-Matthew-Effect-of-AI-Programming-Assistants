public class Solution {

import java.util.*;

public class Solution {
    public int minimumJump(String sequence, int[] forward, int[] backward) {
        int n = sequence.length();
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[0] = 0;
        Queue<Integer> queue = new LinkedList<>();
        queue.add(0);

        boolean[] visited = new boolean[n];
        visited[0] = true;

        while (!queue.isEmpty()) {
            int current = queue.poll();
            int next = current + 1;
            if (next < n && !visited[next]) {
                if (sequence.charAt(next) == '0') {
                    dist[next] = Math.min(dist[next], dist[current] + 1);
                    queue.add(next);
                    visited[next] = true;
                }
            }
            if (forward[current] > 0 && !visited[forward[current]]) {
                dist[forward[current]] = Math.min(dist[forward[current]], dist[current] + 1);
                queue.add(forward[current]);
                visited[forward[current]] = true;
            }
            if (backward[current] > 0 && !visited[backward[current]]) {
                dist[backward[current]] = Math.min(dist[backward[current]], dist[current] + 1);
                queue.add(backward[current]);
                visited[backward[current]] = true;
            }
        }

        return dist[n - 1] == Integer.MAX_VALUE ? -1 : dist[n - 1];
    }
}
}