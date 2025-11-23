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

        vector<double> results;
        for (const auto& query : queries) {
            string start = query[0];
            string end = query[1];
            if (graph.find(start) == graph.end() || graph.find(end) == graph.end()) {
                results.push_back(-1.0);
                continue;
            }
            unordered_set<string> visited;
            double res = dfs(start, end, graph, visited);
            results.push_back(res);
        }
        return results;
    }

private:
    double dfs(const string& current, const string& target, unordered_map<string, unordered_map<string, double>>& graph, unordered_set<string>& visited) {
        if (current == target) return 1.0;
        visited.insert(current);
        for (const auto& neighbor : graph[current]) {
            string next = neighbor.first;
            double weight = neighbor.second;
            if (visited.find(next) == visited.end()) {
                double res = dfs(next, target, graph, visited);
                if (res != -1.0) {
                    return weight * res;
                }
            }
        }
        return -1.0;
    }
};