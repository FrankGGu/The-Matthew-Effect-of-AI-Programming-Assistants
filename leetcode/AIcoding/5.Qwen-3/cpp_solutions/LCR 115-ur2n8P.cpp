#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool sequenceReconstruction(vector<int>& nums, vector<vector<int>>& edges) {
        unordered_map<int, vector<int>> graph;
        unordered_map<int, int> inDegree;

        for (int num : nums) {
            inDegree[num] = 0;
        }

        for (const auto& edge : edges) {
            int from = edge[0];
            int to = edge[1];
            graph[from].push_back(to);
            inDegree[to]++;
        }

        queue<int> q;
        for (const auto& pair : inDegree) {
            if (pair.second == 0) {
                q.push(pair.first);
            }
        }

        int count = 0;
        while (!q.empty()) {
            if (q.size() > 1) {
                return false;
            }
            int node = q.front();
            q.pop();
            count++;
            for (int neighbor : graph[node]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        return count == nums.size();
    }
};