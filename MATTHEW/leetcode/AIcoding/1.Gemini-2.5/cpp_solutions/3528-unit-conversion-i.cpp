#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <queue>
#include <utility>

class Solution {
public:
    std::vector<double> calcEquation(
        std::vector<std::vector<std::string>>& equations,
        std::vector<double>& values,
        std::vector<std::vector<std::string>>& queries) {

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
            double result = -1.0;
            bool found = false;

            while (!q.empty() && !found) {
                auto [currentNode, currentValue] = q.front();
                q.pop();

                if (currentNode == end) {
                    result = currentValue;
                    found = true;
                }

                for (const auto& neighbor : adj[currentNode]) {
                    if (found) break;
                    const std::string& nextNode = neighbor.first;
                    double factor = neighbor.second;
                    if (visited.find(nextNode) == visited.end()) {
                        visited.insert(nextNode);
                        q.push({nextNode, currentValue * factor});
                    }
                }
            }
            results.push_back(result);
        }
        return results;
    }
};