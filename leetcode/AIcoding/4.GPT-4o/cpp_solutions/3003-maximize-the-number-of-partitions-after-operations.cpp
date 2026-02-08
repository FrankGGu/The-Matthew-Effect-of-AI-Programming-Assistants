class Solution {
public:
    int maximizePartitions(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        long long total = prefix[n];
        long long max_partitions = 0;

        for (int i = 1; i <= n; ++i) {
            if (prefix[i] - prefix[0] <= total / k) {
                max_partitions = i;
            }
        }

        return max_partitions;
    }
};