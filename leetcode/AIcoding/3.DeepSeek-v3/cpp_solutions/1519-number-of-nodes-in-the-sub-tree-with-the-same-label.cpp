#include <vector>
using namespace std;

class Solution {
public:
    vector<int> countSubTrees(int n, vector<vector<int>>& edges, string labels) {
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> ans(n, 0);
        dfs(0, -1, graph, labels, ans);
        return ans;
    }

    vector<int> dfs(int node, int parent, vector<vector<int>>& graph, string& labels, vector<int>& ans) {
        vector<int> nodeCount(26, 0);
        nodeCount[labels[node] - 'a'] = 1;

        for (int child : graph[node]) {
            if (child == parent) continue;
            vector<int> childCount = dfs(child, node, graph, labels, ans);
            for (int i = 0; i < 26; i++) {
                nodeCount[i] += childCount[i];
            }
        }

        ans[node] = nodeCount[labels[node] - 'a'];
        return nodeCount;
    }
};