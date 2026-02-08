class Solution {
public:
    double calcEquation(vector<vector<string>>& equations, vector<double>& values, vector<vector<string>>& queries) {
        unordered_map<string, vector<pair<string, double>>> graph;
        for (int i = 0; i < equations.size(); ++i) {
            graph[equations[i][0]].emplace_back(equations[i][1], values[i]);
            graph[equations[i][1]].emplace_back(equations[i][0], 1.0 / values[i]);
        }

        unordered_map<string, double> visited;
        vector<double> result;

        for (const auto& query : queries) {
            if (graph.find(query[0]) == graph.end() || graph.find(query[1]) == graph.end()) {
                result.push_back(-1.0);
            } else {
                visited.clear();
                double res = dfs(query[0], query[1], 1.0, graph, visited);
                result.push_back(res);
            }
        }

        return result;
    }

    double dfs(const string& start, const string& end, double value, unordered_map<string, vector<pair<string, double>>>& graph, unordered_map<string, double>& visited) {
        if (start == end) return value;
        visited[start] = value;

        for (const auto& neighbor : graph[start]) {
            if (visited.find(neighbor.first) == visited.end()) {
                double result = dfs(neighbor.first, end, value * neighbor.second, graph, visited);
                if (result != -1.0) return result;
            }
        }

        visited.erase(start);
        return -1.0;
    }
};