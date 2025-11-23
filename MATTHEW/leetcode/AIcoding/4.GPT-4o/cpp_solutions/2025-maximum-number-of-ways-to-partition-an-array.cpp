class Solution {
public:
    int waysToPartition(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        unordered_map<long long, int> count;
        for (int i = 1; i < n; ++i) {
            long long left = prefix[i];
            long long right = prefix[n] - left;
            count[left] += 1;
            count[right] += 1;
        }

        int maxWays = 0;
        for (const auto& [sum, cnt] : count) {
            maxWays = max(maxWays, cnt);
        }

        return maxWays;
    }
};