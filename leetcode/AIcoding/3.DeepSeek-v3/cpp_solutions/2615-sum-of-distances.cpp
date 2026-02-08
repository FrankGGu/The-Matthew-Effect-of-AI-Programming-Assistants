class Solution {
public:
    vector<long long> distance(vector<int>& nums) {
        unordered_map<int, vector<int>> mp;
        for (int i = 0; i < nums.size(); ++i) {
            mp[nums[i]].push_back(i);
        }

        vector<long long> res(nums.size(), 0);
        for (auto& [num, indices] : mp) {
            int n = indices.size();
            if (n == 1) {
                res[indices[0]] = 0;
                continue;
            }
            vector<long long> prefix(n, 0);
            prefix[0] = indices[0];
            for (int i = 1; i < n; ++i) {
                prefix[i] = prefix[i-1] + indices[i];
            }

            for (int i = 0; i < n; ++i) {
                long long left = (long long)indices[i] * (i + 1) - prefix[i];
                long long right = (prefix[n-1] - prefix[i]) - (long long)indices[i] * (n - 1 - i);
                res[indices[i]] = left + right;
            }
        }
        return res;
    }
};