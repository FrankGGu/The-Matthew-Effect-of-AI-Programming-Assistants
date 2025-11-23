#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minTimeToReachLastRoom(vector<vector<int>>& room) {
        int n = room.size();
        int m = room[0].size();
        vector<vector<int>> dist(n, vector<int>(m, INT_MAX));
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<>> pq;
        pq.push({room[0][0], {0, 0}});
        dist[0][0] = room[0][0];

        int dx[] = {-1, 1, 0, 0};
        int dy[] = {0, 0, -1, 1};

        while (!pq.empty()) {
            auto [time, pos] = pq.top();
            pq.pop();
            int x = pos.first;
            int y = pos.second;

            if (x == n - 1 && y == m - 1) {
                return time;
            }

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];
                if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
                    int new_time = time + room[nx][ny];
                    if (new_time < dist[nx][ny]) {
                        dist[nx][ny] = new_time;
                        pq.push({new_time, {nx, ny}});
                    }
                }
            }
        }

        return -1;
    }
};