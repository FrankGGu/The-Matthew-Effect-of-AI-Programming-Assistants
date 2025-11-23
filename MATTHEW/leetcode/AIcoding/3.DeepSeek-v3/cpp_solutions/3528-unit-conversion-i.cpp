#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    double query(string start, string end, unordered_map<string, unordered_map<string, double>>& graph) {
        if (graph.find(start) == graph.end() || graph.find(end) == graph.end()) {
            return -1.0;
        }
        if (start == end) {
            return 1.0;
        }
        queue<pair<string, double>> q;
        unordered_set<string> visited;
        q.push({start, 1.0});
        visited.insert(start);
        while (!q.empty()) {
            auto current = q.front();
            q.pop();
            string node = current.first;
            double current_val = current.second;
            for (auto neighbor : graph[node]) {
                string next_node = neighbor.first;
                double edge_val = neighbor.second;
                if (next_node == end) {
                    return current_val * edge_val;
                }
                if (visited.find(next_node) == visited.end()) {
                    visited.insert(next_node);
                    q.push({next_node, current_val * edge_val});
                }
            }
        }
        return -1.0;
    }

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
        for (auto& query_pair : queries) {
            string start = query_pair[0];
            string end = query_pair[1];
            results.push_back(query(start, end, graph));
        }
        return results;
    }
};