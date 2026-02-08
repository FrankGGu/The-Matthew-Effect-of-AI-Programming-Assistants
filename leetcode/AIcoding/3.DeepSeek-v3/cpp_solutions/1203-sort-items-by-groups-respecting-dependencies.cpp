class Solution {
public:
    vector<int> sortItems(int n, int m, vector<int>& group, vector<vector<int>>& beforeItems) {
        int groupId = m;
        for (int i = 0; i < n; i++) {
            if (group[i] == -1) {
                group[i] = groupId++;
            }
        }

        unordered_map<int, vector<int>> itemGraph;
        unordered_map<int, int> itemIndegree;
        for (int i = 0; i < n; i++) {
            itemGraph[i] = vector<int>();
        }

        unordered_map<int, vector<int>> groupGraph;
        unordered_map<int, int> groupIndegree;
        for (int i = 0; i < groupId; i++) {
            groupGraph[i] = vector<int>();
        }

        for (int i = 0; i < n; i++) {
            for (int before : beforeItems[i]) {
                itemGraph[before].push_back(i);
                itemIndegree[i]++;
                if (group[i] != group[before]) {
                    groupGraph[group[before]].push_back(group[i]);
                    groupIndegree[group[i]]++;
                }
            }
        }

        vector<int> itemOrder = topologicalSort(itemGraph, itemIndegree);
        vector<int> groupOrder = topologicalSort(groupGraph, groupIndegree);

        if (itemOrder.empty() || groupOrder.empty()) {
            return vector<int>();
        }

        unordered_map<int, vector<int>> orderedGroups;
        for (int item : itemOrder) {
            orderedGroups[group[item]].push_back(item);
        }

        vector<int> result;
        for (int groupId : groupOrder) {
            if (orderedGroups.find(groupId) != orderedGroups.end()) {
                for (int item : orderedGroups[groupId]) {
                    result.push_back(item);
                }
            }
        }

        return result;
    }

private:
    vector<int> topologicalSort(unordered_map<int, vector<int>>& graph, unordered_map<int, int>& indegree) {
        vector<int> result;
        queue<int> q;
        for (auto& entry : graph) {
            if (indegree[entry.first] == 0) {
                q.push(entry.first);
            }
        }

        while (!q.empty()) {
            int current = q.front();
            q.pop();
            result.push_back(current);

            for (int neighbor : graph[current]) {
                indegree[neighbor]--;
                if (indegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        if (result.size() == graph.size()) {
            return result;
        }
        return vector<int>();
    }
};