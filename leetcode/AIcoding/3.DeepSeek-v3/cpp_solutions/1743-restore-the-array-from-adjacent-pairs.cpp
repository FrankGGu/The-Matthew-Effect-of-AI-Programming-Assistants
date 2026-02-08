class Solution {
public:
    vector<int> restoreArray(vector<vector<int>>& adjacentPairs) {
        unordered_map<int, vector<int>> graph;
        for (auto& pair : adjacentPairs) {
            graph[pair[0]].push_back(pair[1]);
            graph[pair[1]].push_back(pair[0]);
        }

        int root = 0;
        for (auto& entry : graph) {
            if (entry.second.size() == 1) {
                root = entry.first;
                break;
            }
        }

        vector<int> result;
        dfs(root, graph, result);
        return result;
    }

private:
    void dfs(int node, unordered_map<int, vector<int>>& graph, vector<int>& result) {
        unordered_set<int> visited;
        stack<int> st;
        st.push(node);
        visited.insert(node);

        while (!st.empty()) {
            int current = st.top();
            st.pop();
            result.push_back(current);

            for (int neighbor : graph[current]) {
                if (visited.find(neighbor) == visited.end()) {
                    visited.insert(neighbor);
                    st.push(neighbor);
                }
            }
        }
    }
};