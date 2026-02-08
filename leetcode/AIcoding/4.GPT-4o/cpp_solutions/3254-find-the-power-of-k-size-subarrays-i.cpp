class Solution {
public:
    int countKSizeSubarrays(vector<int>& nums, int k, int threshold) {
        int count = 0;
        int n = nums.size();

        for (int i = 0; i <= n - k; ++i) {
            int sum = 0;
            for (int j = 0; j < k; ++j) {
                sum += nums[i + j];
            }
            if (sum / k >= threshold) {
                count++;
            }
        }

        return count;
    }
};