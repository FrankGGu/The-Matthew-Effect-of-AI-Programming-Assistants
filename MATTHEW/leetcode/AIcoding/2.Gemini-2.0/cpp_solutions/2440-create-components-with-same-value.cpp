#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int componentValue(vector<int>& nums, vector<vector<int>>& edges) {
        int sum = accumulate(nums.begin(), nums.end(), 0);
        int n = nums.size();

        for (int k = n; k >= 1; --k) {
            if (sum % k == 0) {
                int target = sum / k;
                vector<vector<int>> adj(n);
                for (auto& edge : edges) {
                    adj[edge[0]].push_back(edge[1]);
                    adj[edge[1]].push_back(edge[0]);
                }

                vector<int> visited(n, 0);
                bool possible = true;

                function<int(int)> dfs = [&](int u) {
                    visited[u] = 1;
                    int currentSum = nums[u];
                    for (int v : adj[u]) {
                        if (!visited[v]) {
                            int componentSum = dfs(v);
                            if (componentSum == -1) return -1;
                            currentSum += componentSum;
                        }
                    }

                    if (currentSum > target) return -1;
                    if (currentSum == target) return 0;
                    return currentSum;
                };

                int componentsFound = 0;
                for (int i = 0; i < n; ++i) {
                    if (!visited[i]) {
                        int componentSum = dfs(i);
                        if (componentSum == -1) {
                            possible = false;
                            break;
                        }
                        if (componentSum == 0) componentsFound++;
                        else if (componentSum != target && componentSum != 0) {
                            possible = false;
                            break;
                        }
                    }
                }
                if (possible) return k - 1;
            }
        }
        return 0;
    }
};