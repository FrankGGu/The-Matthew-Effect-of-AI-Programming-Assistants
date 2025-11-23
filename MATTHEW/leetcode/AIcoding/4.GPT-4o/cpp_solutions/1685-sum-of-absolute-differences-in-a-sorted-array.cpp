class Solution {
public:
    vector<int> getSumAbsoluteDifferences(vector<int>& nums) {
        int n = nums.size();
        vector<int> result(n);
        long long total = 0;

        for (int num : nums) {
            total += num;
        }

        for (int i = 0; i < n; i++) {
            result[i] = (i * nums[i] - (total - (long long)nums[i])) + ((total - (long long)nums[i]) - (n - i - 1) * nums[i]);
        }

        return result;
    }
};