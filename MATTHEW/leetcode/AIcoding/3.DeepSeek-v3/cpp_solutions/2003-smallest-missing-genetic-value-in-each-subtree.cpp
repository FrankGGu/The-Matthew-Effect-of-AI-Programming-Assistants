class Solution {
public:
    vector<int> smallestMissingValueSubtree(vector<int>& parents, vector<int>& nums) {
        int n = parents.size();
        vector<vector<int>> children(n);
        for (int i = 1; i < n; ++i) {
            children[parents[i]].push_back(i);
        }

        vector<int> res(n, 1);
        int node = -1;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == 1) {
                node = i;
                break;
            }
        }
        if (node == -1) {
            return res;
        }

        unordered_set<int> seen;
        int missing = 1;
        while (node != -1) {
            dfs(node, children, nums, seen);
            while (seen.count(missing)) {
                ++missing;
            }
            res[node] = missing;
            node = parents[node];
        }
        return res;
    }

private:
    void dfs(int node, vector<vector<int>>& children, vector<int>& nums, unordered_set<int>& seen) {
        if (seen.count(nums[node])) {
            return;
        }
        seen.insert(nums[node]);
        for (int child : children[node]) {
            dfs(child, children, nums, seen);
        }
    }
};