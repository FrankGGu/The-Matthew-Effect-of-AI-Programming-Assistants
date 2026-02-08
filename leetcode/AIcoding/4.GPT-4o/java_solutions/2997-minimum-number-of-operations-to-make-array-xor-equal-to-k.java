class Solution {
    public int minimumOperations(int[] nums, int start, int goal) {
        if (start == goal) return 0;
        boolean[] visited = new boolean[1001];
        visited[start] = true;
        Queue<Integer> queue = new LinkedList<>();
        queue.add(start);
        int operations = 0;

        while (!queue.isEmpty()) {
            operations++;
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                for (int num : nums) {
                    int next = current ^ num;
                    if (next == goal) return operations;
                    if (next >= 0 && next <= 1000 && !visited[next]) {
                        visited[next] = true;
                        queue.add(next);
                    }
                }
            }
        }
        return -1;
    }
}