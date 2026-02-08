class Solution {
public:
    vector<int> findPermutation(vector<int>& nums) {
        int n = nums.size();
        vector<int> ans(n);
        for (int i = 0; i < n; ++i) ans[i] = i;
        int min_cost = INT_MAX;
        vector<int> best_perm;
        do {
            int cost = 0;
            for (int i = 0; i < n; ++i) {
                cost += abs(ans[i] - nums[ans[(i + 1) % n]]);
            }
            if (cost < min_cost) {
                min_cost = cost;
                best_perm = ans;
            } else if (cost == min_cost && ans < best_perm) {
                best_perm = ans;
            }
        } while (next_permutation(ans.begin(), ans.end()));
        return best_perm;
    }
};