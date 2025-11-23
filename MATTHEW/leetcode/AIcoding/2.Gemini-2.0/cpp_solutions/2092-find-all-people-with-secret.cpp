#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> findAllPeople(int n, vector<vector<int>>& meetings, int firstPerson) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& meeting : meetings) {
            int x = meeting[0];
            int y = meeting[1];
            int time = meeting[2];
            adj[x].push_back({y, time});
            adj[y].push_back({x, time});
        }

        vector<bool> knowsSecret(n, false);
        knowsSecret[0] = true;
        knowsSecret[firstPerson] = true;

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.push({0, 0});
        pq.push({0, firstPerson});

        while (!pq.empty()) {
            int time = pq.top().first;
            int person = pq.top().second;
            pq.pop();

            if (!knowsSecret[person]) continue;

            for (auto& neighbor : adj[person]) {
                int nextPerson = neighbor.first;
                int nextTime = neighbor.second;

                if (nextTime >= time && !knowsSecret[nextPerson]) {
                    knowsSecret[nextPerson] = true;
                    pq.push({nextTime, nextPerson});
                }
            }
        }

        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (knowsSecret[i]) {
                result.push_back(i);
            }
        }

        return result;
    }
};