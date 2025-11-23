class Solution {
public:
    int maxSumRangeQuery(vector<int>& nums, vector<vector<int>>& requests) {
        vector<int> count(nums.size(), 0);
        for (const auto& req : requests) {
            count[req[0]]++;
            if (req[1] + 1 < nums.size()) {
                count[req[1] + 1]--;
            }
        }

        for (int i = 1; i < count.size(); i++) {
            count[i] += count[i - 1];
        }

        sort(nums.begin(), nums.end(), greater<int>());
        sort(count.begin(), count.end(), greater<int>());

        long long result = 0;
        const int MOD = 1e9 + 7;
        for (int i = 0; i < nums.size(); i++) {
            result = (result + (long long)nums[i] * count[i]) % MOD;
        }

        return result;
    }
};