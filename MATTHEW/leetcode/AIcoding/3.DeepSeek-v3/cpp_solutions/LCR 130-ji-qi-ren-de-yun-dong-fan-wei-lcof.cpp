class Solution {
public:
    int wardrobeFinishing(int m, int n, int cnt) {
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        return dfs(0, 0, m, n, cnt, visited);
    }

    int dfs(int i, int j, int m, int n, int cnt, vector<vector<bool>>& visited) {
        if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || getSum(i) + getSum(j) > cnt) {
            return 0;
        }
        visited[i][j] = true;
        return 1 + dfs(i + 1, j, m, n, cnt, visited) + dfs(i, j + 1, m, n, cnt, visited);
    }

    int getSum(int x) {
        int sum = 0;
        while (x != 0) {
            sum += x % 10;
            x /= 10;
        }
        return sum;
    }
};