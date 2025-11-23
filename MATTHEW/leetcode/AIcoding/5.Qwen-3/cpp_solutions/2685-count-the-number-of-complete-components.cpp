#include <iostream>
#include <vector>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    int countCompleteComponents(vector<vector<int>>& edges) {
        int n = edges.size();
        vector<vector<int>> graph(26);
        vector<bool> visited(26, false);

        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int count = 0;

        for (int i = 0; i < 26; ++i) {
            if (!visited[i] && !graph[i].empty()) {
                queue<int> q;
                q.push(i);
                visited[i] = true;
                unordered_set<int> component;
                component.insert(i);

                while (!q.empty()) {
                    int node = q.front();
                    q.pop();

                    for (int neighbor : graph[node]) {
                        if (!visited[neighbor]) {
                            visited[neighbor] = true;
                            q.push(neighbor);
                            component.insert(neighbor);
                        }
                    }
                }

                bool isComplete = true;
                for (int node : component) {
                    if (graph[node].size() != component.size() - 1) {
                        isComplete = false;
                        break;
                    }
                }

                if (isComplete) {
                    ++count;
                }
            }
        }

        return count;
    }
};