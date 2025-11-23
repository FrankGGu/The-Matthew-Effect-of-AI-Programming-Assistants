class Solution {
public:
    vector<int> getSumAbsoluteDifferences(vector<int>& nums) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        vector<int> result(n);
        for (int i = 0; i < n; ++i) {
            int leftSum = nums[i] * i - prefix[i];
            int rightSum = (prefix[n] - prefix[i + 1]) - nums[i] * (n - i - 1);
            result[i] = leftSum + rightSum;
        }
        return result;
    }
};