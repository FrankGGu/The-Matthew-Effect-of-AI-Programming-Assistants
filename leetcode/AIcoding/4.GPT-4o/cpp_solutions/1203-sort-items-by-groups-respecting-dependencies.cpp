class Solution {
public:
    vector<int> sortItems(int n, int m, vector<int>& group, vector<vector<int>>& beforeItems) {
        vector<vector<int>> graph(n + m), groupGraph(m);
        vector<int> inDegree(n + m), groupInDegree(m);
        vector<int> itemOrder, groupOrder;

        for (int i = 0; i < n; ++i) {
            if (group[i] == -1) {
                group[i] = m++;
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j : beforeItems[i]) {
                graph[j].push_back(i);
                inDegree[i]++;
                if (group[i] != group[j]) {
                    groupGraph[group[j]].push_back(group[i]);
                    groupInDegree[group[i]]++;
                }
            }
        }

        function<bool(int, vector<int>&, vector<vector<int>>&)> topologicalSort = [&](int count, vector<int>& order, vector<vector<int>>& g) {
            queue<int> q;
            for (int i = 0; i < count; ++i) {
                if (g[i].empty()) {
                    q.push(i);
                }
            }
            while (!q.empty()) {
                int curr = q.front();
                q.pop();
                order.push_back(curr);
                for (int next : g[curr]) {
                    if (--inDegree[next] == 0) {
                        q.push(next);
                    }
                }
            }
            return order.size() == count;
        };

        if (!topologicalSort(n, itemOrder, graph) || !topologicalSort(m, groupOrder, groupGraph)) {
            return {};
        }

        vector<vector<int>> groupedItems(m);
        for (int item : itemOrder) {
            groupedItems[group[item]].push_back(item);
        }

        vector<int> result;
        for (int g : groupOrder) {
            result.insert(result.end(), groupedItems[g].begin(), groupedItems[g].end());
        }
        return result;
    }
};