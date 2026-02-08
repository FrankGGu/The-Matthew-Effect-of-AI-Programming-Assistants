class Solution {
public:
    int minimumEffortPath(vector<vector<int>>& heights) {
        int rows = heights.size();
        int cols = heights[0].size();
        vector<vector<int>> efforts(rows, vector<int>(cols, INT_MAX));
        efforts[0][0] = 0;

        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        pq.push({0, {0, 0}});

        vector<pair<int, int>> dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!pq.empty()) {
            auto curr = pq.top();
            pq.pop();
            int currEffort = curr.first;
            int x = curr.second.first;
            int y = curr.second.second;

            if (x == rows - 1 && y == cols - 1) {
                return currEffort;
            }

            for (auto dir : dirs) {
                int nx = x + dir.first;
                int ny = y + dir.second;

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                    int newEffort = max(currEffort, abs(heights[nx][ny] - heights[x][y]));
                    if (newEffort < efforts[nx][ny]) {
                        efforts[nx][ny] = newEffort;
                        pq.push({newEffort, {nx, ny}});
                    }
                }
            }
        }

        return 0;
    }
};