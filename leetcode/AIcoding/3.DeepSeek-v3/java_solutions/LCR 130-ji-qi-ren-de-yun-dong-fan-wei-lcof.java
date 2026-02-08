class Solution {
    public int wardrobeFinishing(int m, int n, int cnt) {
        boolean[][] visited = new boolean[m][n];
        return dfs(0, 0, m, n, cnt, visited);
    }

    private int dfs(int i, int j, int m, int n, int cnt, boolean[][] visited) {
        if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || digitSum(i) + digitSum(j) > cnt) {
            return 0;
        }
        visited[i][j] = true;
        return 1 + dfs(i + 1, j, m, n, cnt, visited) 
                 + dfs(i, j + 1, m, n, cnt, visited);
    }

    private int digitSum(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
}