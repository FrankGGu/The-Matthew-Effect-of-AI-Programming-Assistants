#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <queue>
#include <utility>

class Solution {
public:
    std::vector<double> calcEquation(std::vector<std::vector<std::string>>& equations, std::vector<double>& values, std::vector<std::vector<std::string>>& queries) {
        std::unordered_map<std::string, std::vector<std::pair<std::string, double>>> adj;
        for (int i = 0; i < equations.size(); ++i) {
            const std::string& u = equations[i][0];
            const std::string& v = equations[i][1];
            double val = values[i];
            adj[u].push_back({v, val});
            adj[v].push_back({u, 1.0 / val});
        }

        std::vector<double> results;
        for (const auto& query : queries) {
            const std::string& start = query[0];
            const std::string& end = query[1];

            if (adj.find(start) == adj.end() || adj.find(end) == adj.end()) {
                results.push_back(-1.0);
                continue;
            }

            std::queue<std::pair<std::string, double>> q;
            q.push({start, 1.0});
            std::unordered_set<std::string> visited;
            visited.insert(start);
            bool found = false;

            while (!q.empty()) {
                std::pair<std::string, double> front = q.front();
                q.pop();
                std::string curr_node = front.first;
                double curr_val = front.second;

                if (curr_node == end) {
                    results.push_back(curr_val);
                    found = true;
                    break;
                }

                for (const auto& edge : adj[curr_node]) {
                    const std::string& next_node = edge.first;
                    double weight = edge.second;
                    if (visited.find(next_node) == visited.end()) {
                        visited.insert(next_node);
                        q.push({next_node, curr_val * weight});
                    }
                }
            }

            if (!found) {
                results.push_back(-1.0);
            }
        }
        return results;
    }
};