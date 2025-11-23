#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> sortItems(int n, int m, vector<int>& group, vector<vector<int>>& beforeItems) {
        for (int i = 0; i < n; ++i) {
            if (group[i] == -1) {
                group[i] = m++;
            }
        }

        vector<vector<int>> itemGraph(n);
        vector<int> itemIndegree(n, 0);
        vector<vector<int>> groupGraph(m);
        vector<int> groupIndegree(m, 0);

        for (int i = 0; i < n; ++i) {
            for (int beforeItem : beforeItems[i]) {
                itemGraph[beforeItem].push_back(i);
                itemIndegree[i]++;

                if (group[beforeItem] != group[i]) {
                    bool found = false;
                    for (int neighbor : groupGraph[group[beforeItem]]) {
                        if (neighbor == group[i]) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        groupGraph[group[beforeItem]].push_back(group[i]);
                        groupIndegree[group[i]]++;
                    }
                }
            }
        }

        vector<int> itemOrder = topologicalSort(itemGraph, itemIndegree, n);
        if (itemOrder.empty()) return {};

        vector<int> groupOrder = topologicalSort(groupGraph, groupIndegree, m);
        if (groupOrder.empty()) return {};

        vector<vector<int>> groupToItems(m);
        for (int item : itemOrder) {
            groupToItems[group[item]].push_back(item);
        }

        vector<int> result;
        for (int groupId : groupOrder) {
            for (int item : groupToItems[groupId]) {
                result.push_back(item);
            }
        }

        return result;
    }

private:
    vector<int> topologicalSort(vector<vector<int>>& graph, vector<int>& indegree, int n) {
        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (indegree[i] == 0) {
                q.push(i);
            }
        }

        vector<int> result;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            result.push_back(u);

            for (int v : graph[u]) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return result.size() == n ? result : vector<int>();
    }
};