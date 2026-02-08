import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.List;
import java.util.Queue;

class Solution {
    public int numWays(int n, int[][] relation, int k) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : relation) {
            adj.get(edge[0]).add(edge[1]);
        }

        int count = 0;
        Queue<Integer> queue = new ArrayDeque<>();
        queue.offer(0);
        int steps = 0;

        while (!queue.isEmpty() && steps <= k) {
            int size = queue.size();
            if (steps == k) {
                for (int i = 0; i < size; i++) {
                    if (queue.poll() == n - 1) {
                        count++;
                    }
                }
                break;
            }
            for (int i = 0; i < size; i++) {
                int curr = queue.poll();
                for (int neighbor : adj.get(curr)) {
                    queue.offer(neighbor);
                }
            }
            steps++;
        }

        return count;
    }
}