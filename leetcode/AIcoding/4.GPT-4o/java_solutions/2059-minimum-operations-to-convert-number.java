class Solution {
    public int minimumOperations(int start, int target, int[] A) {
        boolean[] visited = new boolean[1001];
        Queue<Integer> queue = new LinkedList<>();
        queue.add(start);
        visited[start] = true;
        int operations = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                if (current == target) return operations;

                for (int num : A) {
                    int next = current + num;
                    if (next >= 0 && next <= 1000 && !visited[next]) {
                        visited[next] = true;
                        queue.add(next);
                    }
                }
            }
            operations++;
        }

        return -1;
    }
}