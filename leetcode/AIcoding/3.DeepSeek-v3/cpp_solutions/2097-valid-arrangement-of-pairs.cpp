class Solution {
public:
    vector<vector<int>> validArrangement(vector<vector<int>>& pairs) {
        unordered_map<int, vector<int>> graph;
        unordered_map<int, int> inDegree, outDegree;

        for (auto& p : pairs) {
            int u = p[0], v = p[1];
            graph[u].push_back(v);
            outDegree[u]++;
            inDegree[v]++;
        }

        int start = pairs[0][0];
        for (auto& [u, _] : graph) {
            if (outDegree[u] - inDegree[u] == 1) {
                start = u;
                break;
            }
        }

        vector<vector<int>> result;
        stack<int> st;
        st.push(start);

        while (!st.empty()) {
            int u = st.top();
            if (!graph[u].empty()) {
                int v = graph[u].back();
                graph[u].pop_back();
                st.push(v);
            } else {
                if (st.size() > 1) {
                    int v = st.top();
                    st.pop();
                    result.push_back({st.top(), v});
                } else {
                    st.pop();
                }
            }
        }

        reverse(result.begin(), result.end());
        return result;
    }
};