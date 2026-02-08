class Solution {
public:
    vector<double> calcEquation(vector<vector<string>>& equations, vector<double>& values, vector<vector<string>>& queries) {
        unordered_map<string, unordered_map<string, double>> graph;
        for (int i = 0; i < equations.size(); ++i) {
            string u = equations[i][0];
            string v = equations[i][1];
            double val = values[i];
            graph[u][v] = val;
            graph[v][u] = 1.0 / val;
        }

        vector<double> res;
        for (auto& query : queries) {
            string start = query[0];
            string end = query[1];
            if (graph.find(start) == graph.end() || graph.find(end) == graph.end()) {
                res.push_back(-1.0);
                continue;
            }
            unordered_set<string> visited;
            double ans = -1.0;
            dfs(start, end, graph, visited, 1.0, ans);
            res.push_back(ans);
        }
        return res;
    }

    void dfs(string node, string target, unordered_map<string, unordered_map<string, double>>& graph, unordered_set<string>& visited, double current, double& ans) {
        if (node == target) {
            ans = current;
            return;
        }
        visited.insert(node);
        for (auto& neighbor : graph[node]) {
            string next = neighbor.first;
            double val = neighbor.second;
            if (visited.find(next) == visited.end()) {
                dfs(next, target, graph, visited, current * val, ans);
            }
        }
    }
};