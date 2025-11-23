#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int componentValue(vector<int>& nums, vector<int>& edges) {
        int n = nums.size();
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int total = 0;
        for (int num : nums) {
            total += num;
        }

        for (int i = 1; i <= total; ++i) {
            if (total % i != 0) continue;
            int target = i;
            vector<bool> visited(n, false);
            int count = 0;

            function<bool(int)> dfs = [&](int node) {
                visited[node] = true;
                int sum = nums[node];
                for (int neighbor : graph[node]) {
                    if (!visited[neighbor]) {
                        sum += dfs(neighbor);
                    }
                }
                return sum == target;
            };

            for (int j = 0; j < n; ++j) {
                if (!visited[j] && dfs(j)) {
                    ++count;
                }
            }

            if (count >= 2 && total / target == count) {
                return target;
            }
        }

        return 0;
    }
};