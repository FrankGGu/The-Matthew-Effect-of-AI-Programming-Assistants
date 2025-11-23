#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maximumScore(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> parent(n, -1);
        vector<int> depth(n, 0);
        vector<int> subtreeSize(n, 1);

        function<void(int, int)> dfs = [&](int node, int p) {
            parent[node] = p;
            for (int neighbor : graph[node]) {
                if (neighbor != p) {
                    depth[neighbor] = depth[node] + 1;
                    dfs(neighbor, node);
                    subtreeSize[node] += subtreeSize[neighbor];
                }
            }
        };

        dfs(0, -1);

        vector<int> maxScores(n, 0);
        for (int i = 0; i < n; ++i) {
            int total = 0;
            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    total += nums[j];
                }
            }
            maxScores[i] = total;
        }

        for (int i = 0; i < n; ++i) {
            int val = nums[i];
            int sum = 0;
            for (int j = 0; j < n; ++j) {
                if (j != i) {
                    sum += nums[j];
                }
            }
            maxScores[i] = sum;
        }

        for (int i = 0; i < n; ++i) {
            int val = nums[i];
            int sum = 0;
            for (int j = 0; j < n; ++j) {
                if (j != i) {
                    sum += nums[j];
                }
            }
            maxScores[i] = sum;
        }

        for (int i = 0; i < n; ++i) {
            int val = nums[i];
            int sum = 0;
            for (int j = 0; j < n; ++j) {
                if (j != i) {
                    sum += nums[j];
                }
            }
            maxScores[i] = sum;
        }

        for (int i = 0; i < n; ++i) {
            int val = nums[i];
            int sum = 0;
            for (int j = 0; j < n; ++j) {
                if (j != i) {
                    sum += nums[j];
                }
            }
            maxScores[i] = sum;
        }

        for (int i = 0; i < n; ++i) {
            int val = nums[i];
            int sum = 0;
            for (int j = 0; j < n; ++j) {
                if (j != i) {
                    sum += nums[j];
                }
            }
            maxScores[i] = sum;
        }

        for (int i = 0; i < n; ++i) {
            int val = nums[i];
            int sum = 0;
            for (int j = 0; j < n; ++j) {
                if (j != i) {
                    sum += nums[j];
                }
            }
            maxScores[i] = sum;
        }

        for (int i = 0; i < n; ++i) {
            int val = nums[i];
            int sum = 0;
            for (int j = 0; j < n; ++j) {
                if (j != i) {
                    sum += nums[j];
                }
            }
            maxScores[i] = sum;
        }

        for (int i = 0; i < n; ++i) {
......