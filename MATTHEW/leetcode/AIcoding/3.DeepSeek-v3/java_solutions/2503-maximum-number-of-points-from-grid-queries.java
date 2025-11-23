class Solution {
    public int[] maxPoints(int[][] grid, int[] queries) {
        int m = grid.length;
        int n = grid[0].length;
        int k = queries.length;
        int[] res = new int[k];
        int[][] queriesWithIndex = new int[k][2];
        for (int i = 0; i < k; i++) {
            queriesWithIndex[i][0] = queries[i];
            queriesWithIndex[i][1] = i;
        }
        Arrays.sort(queriesWithIndex, (a, b) -> a[0] - b[0]);

        PriorityQueue<int[]> minHeap = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        boolean[][] visited = new boolean[m][n];
        minHeap.offer(new int[]{0, 0, grid[0][0]});
        visited[0][0] = true;
        int count = 0;
        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        for (int[] query : queriesWithIndex) {
            int q = query[0];
            int idx = query[1];
            while (!minHeap.isEmpty() && minHeap.peek()[2] < q) {
                int[] curr = minHeap.poll();
                count++;
                for (int[] dir : dirs) {
                    int x = curr[0] + dir[0];
                    int y = curr[1] + dir[1];
                    if (x >= 0 && x < m && y >= 0 && y < n && !visited[x][y]) {
                        visited[x][y] = true;
                        minHeap.offer(new int[]{x, y, grid[x][y]});
                    }
                }
            }
            res[idx] = count;
        }
        return res;
    }
}