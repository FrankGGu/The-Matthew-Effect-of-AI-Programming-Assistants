class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        sort(nums.begin(), nums.end());
        vector<int> uniqueNums;
        for (int num : nums) {
            if (uniqueNums.empty() || num != uniqueNums.back()) {
                uniqueNums.push_back(num);
            }
        }
        int m = uniqueNums.size();
        int res = n;
        for (int i = 0; i < m; ++i) {
            int left = uniqueNums[i];
            int right = left + n - 1;
            int j = upper_bound(uniqueNums.begin(), uniqueNums.end(), right) - uniqueNums.begin();
            res = min(res, n - (j - i));
        }
        return res;
    }
};