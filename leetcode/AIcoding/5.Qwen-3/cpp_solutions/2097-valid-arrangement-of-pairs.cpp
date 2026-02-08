#include <iostream>
#include <vector>
#include <unordered_map>
#include <stack>

using namespace std;

class Solution {
public:
    vector<vector<int>> validArrangement(int n, vector<vector<int>>& pairs) {
        unordered_map<int, vector<int>> graph;
        vector<int> inDegree(n, 0);

        for (const auto& p : pairs) {
            graph[p[0]].push_back(p[1]);
            inDegree[p[1]]++;
        }

        int startNode = 0;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] > 0) {
                startNode = i;
                break;
            }
        }

        stack<int> s;
        vector<int> path;

        s.push(startNode);
        while (!s.empty()) {
            int u = s.top();
            if (!graph[u].empty()) {
                int v = graph[u].back();
                graph[u].pop_back();
                s.push(v);
            } else {
                path.push_back(u);
                s.pop();
            }
        }

        vector<vector<int>> result;
        for (int i = path.size() - 1; i > 0; --i) {
            result.push_back({path[i - 1], path[i]});
        }

        return result;
    }
};