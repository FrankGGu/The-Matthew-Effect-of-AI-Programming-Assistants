#include <vector>
#include <string>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<double> calcEquation(vector<vector<string>>& equations, vector<double>& values, vector<vector<string>>& queries) {
        unordered_map<string, vector<pair<string, double>>> adj;
        for (int i = 0; i < equations.size(); ++i) {
            adj[equations[i][0]].push_back({equations[i][1], values[i]});
            adj[equations[i][1]].push_back({equations[i][0], 1.0 / values[i]});
        }

        vector<double> results;
        for (const auto& query : queries) {
            string start = query[0];
            string end = query[1];

            if (adj.find(start) == adj.end() || adj.find(end) == adj.end()) {
                results.push_back(-1.0);
                continue;
            }

            queue<pair<string, double>> q;
            unordered_map<string, bool> visited;
            q.push({start, 1.0});
            visited[start] = true;
            double result = -1.0;

            while (!q.empty()) {
                string curr_node = q.front().first;
                double curr_val = q.front().second;
                q.pop();

                if (curr_node == end) {
                    result = curr_val;
                    break;
                }

                for (const auto& neighbor : adj[curr_node]) {
                    if (visited.find(neighbor.first) == visited.end()) {
                        q.push({neighbor.first, curr_val * neighbor.second});
                        visited[neighbor.first] = true;
                    }
                }
            }
            results.push_back(result);
        }
        return results;
    }
};