class Solution {
    public int snakesAndLadders(int[][] board) {
        int n = board.length;
        boolean[] visited = new boolean[n * n + 1];
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(1);
        visited[1] = true;
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int curr = queue.poll();
                if (curr == n * n) {
                    return steps;
                }
                for (int j = 1; j <= 6 && curr + j <= n * n; j++) {
                    int next = curr + j;
                    int[] pos = getPosition(next, n);
                    int row = pos[0], col = pos[1];
                    int dest = board[row][col] == -1 ? next : board[row][col];
                    if (!visited[dest]) {
                        visited[dest] = true;
                        queue.offer(dest);
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    private int[] getPosition(int num, int n) {
        int row = (num - 1) / n;
        int col = (num - 1) % n;
        if (row % 2 != 0) {
            col = n - 1 - col;
        }
        row = n - 1 - row;
        return new int[]{row, col};
    }
}