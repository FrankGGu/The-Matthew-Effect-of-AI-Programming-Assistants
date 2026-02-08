#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool possibleBipartition(vector<int>& nums, vector<vector<int>>& graph) {
        int n = nums.size();
        vector<int> color(n, 0);

        for (int i = 0; i < n; ++i) {
            if (color[i] == 0) {
                queue<int> q;
                q.push(i);
                color[i] = 1;

                while (!q.empty()) {
                    int node = q.front();
                    q.pop();

                    for (int neighbor : graph[node]) {
                        if (color[neighbor] == 0) {
                            color[neighbor] = -color[node];
                            q.push(neighbor);
                        } else if (color[neighbor] == color[node]) {
                            return false;
                        }
                    }
                }
            }
        }

        return true;
    }

    bool possibleBipartition(int n, vector<vector<int>>& dislikes) {
        vector<vector<int>> graph(n, vector<int>());
        for (const auto& pair : dislikes) {
            graph[pair[0] - 1].push_back(pair[1] - 1);
            graph[pair[1] - 1].push_back(pair[0] - 1);
        }

        vector<int> color(n, 0);

        for (int i = 0; i < n; ++i) {
            if (color[i] == 0) {
                queue<int> q;
                q.push(i);
                color[i] = 1;

                while (!q.empty()) {
                    int node = q.front();
                    q.pop();

                    for (int neighbor : graph[node]) {
                        if (color[neighbor] == 0) {
                            color[neighbor] = -color[node];
                            q.push(neighbor);
                        } else if (color[neighbor] == color[node]) {
                            return false;
                        }
                    }
                }
            }
        }

        return true;
    }
};