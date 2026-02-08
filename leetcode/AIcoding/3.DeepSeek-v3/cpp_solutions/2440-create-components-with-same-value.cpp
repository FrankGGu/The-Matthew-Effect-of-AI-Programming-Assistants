class Solution {
public:
    int componentValue(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        if (n == 1) return 0;
        vector<vector<int>> graph(n);
        for (auto& e : edges) {
            graph[e[0]].push_back(e[1]);
            graph[e[1]].push_back(e[0]);
        }

        int total = accumulate(nums.begin(), nums.end(), 0);
        vector<int> divisors;
        for (int i = 1; i * i <= total; ++i) {
            if (total % i == 0) {
                if (i <= total / 2) divisors.push_back(i);
                if (total / i <= total / 2 && i != total / i) divisors.push_back(total / i);
            }
        }
        sort(divisors.rbegin(), divisors.rend());

        for (int d : divisors) {
            if (total % d != 0) continue;
            if (dfs(0, -1, d, nums, graph) == 0) {
                return total / d - 1;
            }
        }
        return 0;
    }

    int dfs(int u, int parent, int target, vector<int>& nums, vector<vector<int>>& graph) {
        int sum = nums[u];
        for (int v : graph[u]) {
            if (v == parent) continue;
            sum += dfs(v, u, target, nums, graph);
            if (sum > target) return target + 1;
        }
        if (sum == target) return 0;
        return sum;
    }
};