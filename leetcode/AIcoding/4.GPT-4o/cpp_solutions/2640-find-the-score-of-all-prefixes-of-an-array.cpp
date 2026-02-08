class Solution {
public:
    vector<long long> findPrefixScore(vector<int>& nums) {
        int n = nums.size();
        vector<long long> result(n);
        long long maxNum = 0, prefixScore = 0;

        for (int i = 0; i < n; ++i) {
            maxNum = max(maxNum, (long long)nums[i]);
            prefixScore += maxNum + nums[i];
            result[i] = prefixScore;
        }

        return result;
    }
};