class Solution {
    public int minJumps(int[] arr) {
        int n = arr.length;
        if (n == 1) return 0;

        Map<Integer, List<Integer>> valueIndices = new HashMap<>();
        for (int i = 0; i < n; i++) {
            valueIndices.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }

        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[n];
        queue.offer(0);
        visited[0] = true;
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                if (current == n - 1) return steps;

                List<Integer> neighbors = valueIndices.get(arr[current]);
                neighbors.add(current - 1);
                neighbors.add(current + 1);

                for (int neighbor : neighbors) {
                    if (neighbor >= 0 && neighbor < n && !visited[neighbor]) {
                        visited[neighbor] = true;
                        queue.offer(neighbor);
                    }
                }
                neighbors.clear();
            }
            steps++;
        }
        return -1;
    }
}