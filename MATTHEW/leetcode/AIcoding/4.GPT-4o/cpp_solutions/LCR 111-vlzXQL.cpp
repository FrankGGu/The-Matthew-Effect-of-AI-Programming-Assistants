#include <unordered_map>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    double calcEquation(vector<vector<string>>& equations, vector<double>& values, vector<vector<string>>& queries) {
        unordered_map<string, unordered_map<string, double>> graph;

        for (int i = 0; i < equations.size(); ++i) {
            string u = equations[i][0], v = equations[i][1];
            graph[u][v] = values[i];
            graph[v][u] = 1.0 / values[i];
        }

        vector<double> results;
        for (auto& query : queries) {
            string start = query[0], end = query[1];
            if (graph.find(start) == graph.end() || graph.find(end) == graph.end()) {
                results.push_back(-1.0);
                continue;
            }
            unordered_set<string> visited;
            results.push_back(dfs(graph, visited, start, end, 1.0));
        }
        return results;
    }

private:
    double dfs(unordered_map<string, unordered_map<string, double>>& graph, unordered_set<string>& visited, string current, string target, double value) {
        if (current == target) return value;
        visited.insert(current);

        for (auto& neighbor : graph[current]) {
            if (visited.find(neighbor.first) == visited.end()) {
                double result = dfs(graph, visited, neighbor.first, target, value * neighbor.second);
                if (result != -1.0) return result;
            }
        }

        return -1.0;
    }
};