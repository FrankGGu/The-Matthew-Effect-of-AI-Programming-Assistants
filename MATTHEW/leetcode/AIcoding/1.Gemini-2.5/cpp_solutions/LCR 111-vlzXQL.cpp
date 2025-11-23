#include <vector>
#include <string>
#include <map>
#include <set>
#include <utility>

class Solution {
public:
    double dfs(const std::string& current_node, const std::string& target_node, double current_product,
               std::set<std::string>& visited, const std::map<std::string, std::map<std::string, double>>& graph) {

        visited.insert(current_node);

        if (current_node == target_node) {
            return current_product;
        }

        if (graph.count(current_node)) {
            for (const auto& neighbor_entry : graph.at(current_node)) {
                const std::string& neighbor = neighbor_entry.first;
                double value = neighbor_entry.second;

                if (visited.find(neighbor) == visited.end()) {
                    double result = dfs(neighbor, target_node, current_product * value, visited, graph);
                    if (result != -1.0) {
                        return result;
                    }
                }
            }
        }

        return -1.0; // No path found from this branch
    }

    std::vector<double> calcEquation(std::vector<std::vector<std::string>>& equations,
                                     std::vector<double>& values,
                                     std::vector<std::vector<std::string>>& queries) {

        std::map<std::string, std::map<std::string, double>> graph;

        for (size_t i = 0; i < equations.size(); ++i) {
            const std::string& u = equations[i][0];
            const std::string& v = equations[i][1];
            double val = values[i];

            graph[u][v] = val;
            graph[v][u] = 1.0 / val;
        }

        std::vector<double> results;
        for (const auto& query : queries) {
            const std::string& start_node = query[0];
            const std::string& end_node = query[1];

            if (graph.find(start_node) == graph.end() || graph.find(end_node) == graph.end()) {
                results.push_back(-1.0);
            } else if (start_node == end_node) {
                results.push_back(1.0);
            } else {
                std::set<std::string> visited;
                results.push_back(dfs(start_node, end_node, 1.0, visited, graph));
            }
        }

        return results;
    }
};