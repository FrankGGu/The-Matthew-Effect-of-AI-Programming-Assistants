class Solution {
public:
    int minOperations(vector<int>& arr, int k) {
        int n = arr.size();
        int ans = 0;

        for (int i = 0; i < k; ++i) {
            vector<int> subsequence;
            for (int j = i; j < n; j += k) {
                subsequence.push_back(arr[j]);
            }
            ans += subsequence.size() - lengthOfLIS(subsequence);
        }

        return ans;
    }

    int lengthOfLIS(vector<int>& nums) {
        vector<int> dp;
        for (int num : nums) {
            auto it = lower_bound(dp.begin(), dp.end(), num);
            if (it == dp.end()) {
                dp.push_back(num);
            } else {
                *it = num;
            }
        }
        return dp.size();
    }
};