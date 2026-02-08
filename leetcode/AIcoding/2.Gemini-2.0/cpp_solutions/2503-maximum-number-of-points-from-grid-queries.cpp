#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> maxPoints(vector<vector<int>>& grid, vector<int>& queries) {
        int m = grid.size();
        int n = grid[0].size();
        int q = queries.size();

        vector<pair<int, int>> indexed_queries(q);
        for (int i = 0; i < q; ++i) {
            indexed_queries[i] = {queries[i], i};
        }
        sort(indexed_queries.begin(), indexed_queries.end());

        vector<int> ans(q);
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;

        if (grid[0][0] < indexed_queries[0].first) {
            pq.push({grid[0][0], 0, 0});
            visited[0][0] = true;
        }

        int points = 0;
        int query_idx = 0;

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (query_idx < q) {
            int current_query_val = indexed_queries[query_idx].first;
            int current_query_index = indexed_queries[query_idx].second;

            while (!pq.empty() && get<0>(pq.top()) < current_query_val) {
                int val = get<0>(pq.top());
                int x = get<1>(pq.top());
                int y = get<2>(pq.top());
                pq.pop();
                points++;

                for (int i = 0; i < 4; ++i) {
                    int nx = x + dx[i];
                    int ny = y + dy[i];

                    if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                        if (grid[nx][ny] < current_query_val) {
                            pq.push({grid[nx][ny], nx, ny});
                            visited[nx][ny] = true;
                        }
                    }
                }
            }
            ans[current_query_index] = points;
            query_idx++;
        }

        return ans;
    }
};