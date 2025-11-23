import java.util.*;

class Solution {
    public int minJumps(int[] arr) {
        int n = arr.length;
        if (n <= 1) return 0;

        Map<Integer, List<Integer>> valueToIndices = new HashMap<>();
        for (int i = 0; i < n; i++) {
            valueToIndices.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }

        Queue<Integer> queue = new LinkedList<>();
        queue.offer(0);

        boolean[] visited = new boolean[n];
        visited[0] = true;

        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int curr = queue.poll();

                if (curr == n - 1) return steps;

                List<Integer> nextIndices = valueToIndices.get(arr[curr]);
                nextIndices.add(curr - 1);
                nextIndices.add(curr + 1);

                for (int next : nextIndices) {
                    if (next >= 0 && next < n && !visited[next]) {
                        queue.offer(next);
                        visited[next] = true;
                    }
                }
                valueToIndices.get(arr[curr]).clear(); // Mark value as visited
            }
            steps++;
        }

        return -1;
    }
}