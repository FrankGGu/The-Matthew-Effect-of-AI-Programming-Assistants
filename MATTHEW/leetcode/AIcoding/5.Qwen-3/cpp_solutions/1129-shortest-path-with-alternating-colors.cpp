#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> shortestAlternatingPaths(int n, vector<vector<int>>& redEdges, vector<vector<int>>& blueEdges) {
        unordered_map<int, vector<int>> redGraph;
        unordered_map<int, vector<int>> blueGraph;

        for (auto& edge : redEdges) {
            redGraph[edge[0]].push_back(edge[1]);
        }

        for (auto& edge : blueEdges) {
            blueGraph[edge[0]].push_back(edge[1]);
        }

        vector<int> result(n, -1);
        vector<vector<int>> dist(n, vector<int>(2, -1));

        queue<pair<int, int>> q;
        q.push({0, 0});
        dist[0][0] = 0;

        while (!q.empty()) {
            auto [node, color] = q.front();
            q.pop();

            if (result[node] == -1) {
                result[node] = dist[node][color];
            }

            int nextColor = 1 - color;

            if (color == 0) {
                for (auto& neighbor : blueGraph[node]) {
                    if (dist[neighbor][nextColor] == -1) {
                        dist[neighbor][nextColor] = dist[node][color] + 1;
                        q.push({neighbor, nextColor});
                    }
                }
            } else {
                for (auto& neighbor : redGraph[node]) {
                    if (dist[neighbor][nextColor] == -1) {
                        dist[neighbor][nextColor] = dist[node][color] + 1;
                        q.push({neighbor, nextColor});
                    }
                }
            }
        }

        return result;
    }
};