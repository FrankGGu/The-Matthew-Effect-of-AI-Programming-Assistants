#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumStarSum(vector<int>& vals, vector<vector<int>>& edges) {
        unordered_map<int, vector<int>> graph;
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int maxSum = 0;
        for (int i = 0; i < vals.size(); ++i) {
            vector<int> neighbors = graph[i];
            sort(neighbors.begin(), neighbors.end(), [&](int a, int b) {
                return vals[a] > vals[b];
            });
            int currentSum = vals[i];
            for (int j = 0; j < neighbors.size() && vals[neighbors[j]] > 0; ++j) {
                currentSum += vals[neighbors[j]];
            }
            maxSum = max(maxSum, currentSum);
        }
        return maxSum;
    }
};