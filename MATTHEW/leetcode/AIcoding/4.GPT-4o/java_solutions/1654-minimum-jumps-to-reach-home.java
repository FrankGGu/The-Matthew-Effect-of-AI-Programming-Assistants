class Solution {
    public int minimumJumps(int[] forbidden, int a, int b, int x) {
        Set<Integer> forbiddenSet = new HashSet<>();
        for (int f : forbidden) {
            forbiddenSet.add(f);
        }

        int maxPos = 2000 + a + b;
        boolean[][] visited = new boolean[maxPos][2];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0});
        visited[0][0] = true;

        int jumps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                int pos = curr[0];
                int canGoBack = curr[1];

                if (pos == x) return jumps;

                if (pos + a < maxPos && !forbiddenSet.contains(pos + a) && !visited[pos + a][1]) {
                    visited[pos + a][1] = true;
                    queue.offer(new int[]{pos + a, 1});
                }

                if (canGoBack == 1 && pos - b >= 0 && !forbiddenSet.contains(pos - b) && !visited[pos - b][0]) {
                    visited[pos - b][0] = true;
                    queue.offer(new int[]{pos - b, 0});
                }

                if (canGoBack == 0 && !forbiddenSet.contains(pos) && !visited[pos][0]) {
                    visited[pos][0] = true;
                    queue.offer(new int[]{pos, 0});
                }
            }
            jumps++;
        }

        return -1;
    }
}