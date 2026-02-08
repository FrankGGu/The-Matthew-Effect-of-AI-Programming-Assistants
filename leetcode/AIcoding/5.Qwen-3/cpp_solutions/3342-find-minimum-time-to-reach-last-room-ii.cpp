#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minTimeToReachLastRoom(vector<int>& roomTypes) {
        int n = roomTypes.size();
        vector<vector<int>> dist(n, vector<int>(2, INT_MAX));
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        dist[0][0] = 0;
        pq.push({0, 0});

        int dx[] = {-1, 1, 0, 0};
        int dy[] = {0, 0, -1, 1};

        while (!pq.empty()) {
            int time = pq.top().first;
            int pos = pq.top().second;
            pq.pop();

            if (pos == n - 1) return time;

            if (time > dist[pos][0]) continue;

            for (int i = 0; i < 4; ++i) {
                int nx = pos + dx[i];
                int ny = pos + dy[i];
                if (nx >= 0 && nx < n && ny >= 0 && ny < n) {
                    int next_pos = nx * n + ny;
                    int next_time = time + 1;
                    if (roomTypes[nx] != roomTypes[ny]) {
                        next_time += 1;
                    }
                    if (next_time < dist[next_pos][0]) {
                        dist[next_pos][0] = next_time;
                        pq.push({next_time, next_pos});
                    }
                }
            }
        }

        return -1;
    }
};