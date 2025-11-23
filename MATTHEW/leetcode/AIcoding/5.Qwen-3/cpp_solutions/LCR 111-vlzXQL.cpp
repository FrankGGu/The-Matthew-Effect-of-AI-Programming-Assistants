#include <iostream>
#include <vector>
#include <map>
#include <queue>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<double> calcEquation(vector<vector<string>>& equations, vector<double>& values, vector<vector<string>>& queries) {
        map<string, vector<pair<string, double>>> graph;
        for (int i = 0; i < equations.size(); ++i) {
            string a = equations[i][0];
            string b = equations[i][1];
            double val = values[i];
            graph[a].push_back({b, val});
            graph[b].push_back({a, 1.0 / val});
        }

        vector<double> result;
        for (const auto& query : queries) {
            string start = query[0];
            string end = query[1];
            if (graph.find(start) == graph.end() || graph.find(end) == graph.end()) {
                result.push_back(-1.0);
                continue;
            }
            if (start == end) {
                result.push_back(1.0);
                continue;
            }

            map<string, bool> visited;
            queue<pair<string, double>> q;
            q.push({start, 1.0});
            visited[start] = true;
            bool found = false;

            while (!q.empty()) {
                auto [node, value] = q.front();
                q.pop();

                for (const auto& neighbor : graph[node]) {
                    if (!visited[neighbor.first]) {
                        if (neighbor.first == end) {
                            result.push_back(value * neighbor.second);
                            found = true;
                            break;
                        }
                        visited[neighbor.first] = true;
                        q.push({neighbor.first, value * neighbor.second});
                    }
                }
                if (found) break;
            }

            if (!found) {
                result.push_back(-1.0);
            }
        }

        return result;
    }
};