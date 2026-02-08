#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<double> calcEquation(vector<vector<string>>& equations, vector<double>& values, vector<vector<string>>& queries) {
        unordered_map<string, unordered_map<string, double>> graph;
        for (int i = 0; i < equations.size(); ++i) {
            string a = equations[i][0];
            string b = equations[i][1];
            double value = values[i];
            graph[a][b] = value;
            graph[b][a] = 1.0 / value;
        }

        vector<double> results;
        for (const auto& query : queries) {
            string start = query[0];
            string end = query[1];
            if (graph.find(start) == graph.end() || graph.find(end) == graph.end()) {
                results.push_back(-1.0);
            } else {
                unordered_set<string> visited;
                double result = dfs(start, end, graph, visited);
                results.push_back(result);
            }
        }
        return results;
    }

private:
    double dfs(string start, string end, unordered_map<string, unordered_map<string, double>>& graph, unordered_set<string>& visited) {
        if (start == end) {
            return 1.0;
        }

        visited.insert(start);
        for (const auto& neighbor : graph[start]) {
            string next = neighbor.first;
            double value = neighbor.second;
            if (visited.find(next) == visited.end()) {
                double result = dfs(next, end, graph, visited);
                if (result != -1.0) {
                    return value * result;
                }
            }
        }
        visited.erase(start);
        return -1.0;
    }
};