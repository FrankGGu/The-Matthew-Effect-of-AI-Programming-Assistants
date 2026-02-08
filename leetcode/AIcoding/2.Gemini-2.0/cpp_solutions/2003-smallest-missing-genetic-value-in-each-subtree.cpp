#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> smallestMissingValueSubtree(vector<int>& parents, vector<int>& nums) {
        int n = parents.size();
        vector<vector<int>> adj(n);
        for (int i = 1; i < n; ++i) {
            adj[parents[i]].push_back(i);
        }

        vector<int> ans(n, 1);
        int node = -1;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == 1) {
                node = i;
                break;
            }
        }

        if (node == -1) {
            return ans;
        }

        vector<bool> seen(n + 2, false);
        int missing = 1;
        while (node != -1) {
            dfs(node, adj, nums, seen);
            while (seen[missing]) {
                missing++;
            }
            ans[node] = missing;
            node = parents[node];
        }

        for (int i = 0; i < n; ++i) {
            if (ans[i] == 1) {
                ans[i] = missing;
            }
        }

        return ans;
    }

private:
    void dfs(int node, vector<vector<int>>& adj, vector<int>& nums, vector<bool>& seen) {
        seen[nums[node]] = true;
        for (int child : adj[node]) {
            dfs(child, adj, nums, seen);
        }
    }
};