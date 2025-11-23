#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> sortItems(int n, int m, vector<int>& group, vector<vector<int>>& beforeItems) {
        vector<vector<int>> graph(n);
        vector<vector<int>> groupGraph(m);
        vector<int> inDegree(n, 0);
        vector<int> groupInDegree(m, 0);
        vector<unordered_set<int>> visited(n);
        vector<unordered_set<int>> groupVisited(m);

        for (int i = 0; i < n; ++i) {
            if (group[i] == -1) {
                continue;
            }
            for (int item : beforeItems[i]) {
                if (group[item] == -1) {
                    continue;
                }
                if (group[item] != group[i]) {
                    groupGraph[group[item]].push_back(group[i]);
                    groupInDegree[group[i]]++;
                }
                graph[item].push_back(i);
                inDegree[i]++;
            }
        }

        vector<int> result;
        queue<int> q;

        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int curr = q.front();
            q.pop();
            result.push_back(curr);
            for (int neighbor : graph[curr]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        if (result.size() != n) {
            return {};
        }

        vector<int> groupResult;
        queue<int> groupQ;

        for (int i = 0; i < m; ++i) {
            if (groupInDegree[i] == 0) {
                groupQ.push(i);
            }
        }

        while (!groupQ.empty()) {
            int currGroup = groupQ.front();
            groupQ.pop();
            for (int i = 0; i < n; ++i) {
                if (group[i] == currGroup) {
                    groupResult.push_back(i);
                }
            }
            for (int neighborGroup : groupGraph[currGroup]) {
                groupInDegree[neighborGroup]--;
                if (groupInDegree[neighborGroup] == 0) {
                    groupQ.push(neighborGroup);
                }
            }
        }

        if (groupResult.size() != n) {
            return {};
        }

        return groupResult;
    }
};