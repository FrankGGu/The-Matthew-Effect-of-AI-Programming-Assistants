#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> findAllPeople(int n, vector<vector<int>>& meetings, int firstPerson) {
        vector<int> result;
        vector<vector<pair<int, int>>> graph(n);

        for (const auto& meeting : meetings) {
            int a = meeting[0], b = meeting[1], time = meeting[2];
            graph[a].push_back({b, time});
            graph[b].push_back({a, time});
        }

        vector<bool> hasSecret(n, false);
        hasSecret[firstPerson] = true;

        for (int i = 0; i < n; ++i) {
            if (hasSecret[i]) {
                queue<int> q;
                q.push(i);
                vector<bool> visited(n, false);
                visited[i] = true;

                while (!q.empty()) {
                    int curr = q.front();
                    q.pop();

                    for (const auto& [neighbor, time] : graph[curr]) {
                        if (!visited[neighbor] && time >= 0) {
                            visited[neighbor] = true;
                            hasSecret[neighbor] = true;
                            q.push(neighbor);
                        }
                    }
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            if (hasSecret[i]) {
                result.push_back(i);
            }
        }

        return result;
    }
};