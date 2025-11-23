class Solution {
    public boolean canVisitAllRooms(List<List<Integer>> rooms) {
        int n = rooms.size();
        boolean[] visited = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(0);
        visited[0] = true;
        int count = 1;

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int key : rooms.get(current)) {
                if (!visited[key]) {
                    visited[key] = true;
                    count++;
                    queue.offer(key);
                }
            }
        }

        return count == n;
    }
}