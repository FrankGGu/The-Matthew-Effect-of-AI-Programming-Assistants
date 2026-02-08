#include <vector>
#include <algorithm>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int maximizeNodes(int n, vector<vector<int>>& edges, int target) {
        unordered_map<int, vector<int>> graph;
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> degree(n, 0);
        for (int i = 0; i < n; ++i) {
            degree[i] = graph[i].size();
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (degree[i] == 1 && i != target) {
                q.push(i);
            degree[i] = 0;
            for (int neighbor : graph[i]) {
                if (degree[neighbor] > 0) {
                    degree[neighbor]--;
                }
            }
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (degree[i] > 0) {
                count++;
            }
        }
        return count;
    }
};