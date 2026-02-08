class Solution {
public:
    long long findXSum(vector<int>& nums, int k) {
        long long result = 0;
        int n = nums.size();
        for (int i = 0; i <= n - k; ++i) {
            long long sum = 0;
            for (int j = i; j < i + k; ++j) {
                sum += nums[j];
            }
            result += sum ^ (i + 1);
        }
        return result;
    }
};