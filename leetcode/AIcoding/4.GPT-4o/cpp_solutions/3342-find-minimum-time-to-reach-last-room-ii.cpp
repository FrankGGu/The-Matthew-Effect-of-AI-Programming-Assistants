#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMinimumTime(vector<vector<int>>& rooms) {
        int n = rooms.size();
        vector<int> dist(n, INT_MAX);
        dist[0] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.push({0, 0});

        while (!pq.empty()) {
            int time = pq.top().first;
            int room = pq.top().second;
            pq.pop();

            for (int i = 0; i < rooms[room].size(); ++i) {
                int nextRoom = rooms[room][i];
                int newTime = time + abs(nextRoom - room) + 1;
                if (newTime < dist[nextRoom]) {
                    dist[nextRoom] = newTime;
                    pq.push({newTime, nextRoom});
                }
            }
        }

        return dist[n - 1];
    }
};