public class Solution {
    public int minJumps(int[] arr) {
        int n = arr.length;
        if (n == 1) return 0;

        int[] dist = new int[n];
        for (int i = 0; i < n; i++) {
            dist[i] = Integer.MAX_VALUE;
        }
        dist[0] = 0;

        java.util.Map<Integer, java.util.List<Integer>> graph = new java.util.HashMap<>();
        for (int i = 0; i < n; i++) {
            graph.putIfAbsent(arr[i], new java.util.ArrayList<>());
            graph.get(arr[i]).add(i);
        }

        java.util.Queue<Integer> queue = new java.util.LinkedList<>();
        queue.add(0);

        while (!queue.isEmpty()) {
            int curr = queue.poll();
            if (curr == n - 1) break;

            for (int next : graph.get(arr[curr])) {
                if (dist[next] == Integer.MAX_VALUE) {
                    dist[next] = dist[curr] + 1;
                    queue.add(next);
                }
            }

            graph.get(arr[curr]).clear();

            if (curr > 0 && dist[curr - 1] == Integer.MAX_VALUE) {
                dist[curr - 1] = dist[curr] + 1;
                queue.add(curr - 1);
            }

            if (curr < n - 1 && dist[curr + 1] == Integer.MAX_VALUE) {
                dist[curr + 1] = dist[curr] + 1;
                queue.add(curr + 1);
            }
        }

        return dist[n - 1];
    }
}