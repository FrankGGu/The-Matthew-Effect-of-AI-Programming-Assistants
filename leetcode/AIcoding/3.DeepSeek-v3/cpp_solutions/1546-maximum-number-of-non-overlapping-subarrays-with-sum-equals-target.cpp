class Solution {
public:
    int maxNonOverlapping(vector<int>& nums, int target) {
        unordered_map<int, int> prefixSum;
        prefixSum[0] = -1;
        int sum = 0;
        int count = 0;
        int lastEnd = -1;

        for (int i = 0; i < nums.size(); ++i) {
            sum += nums[i];
            if (prefixSum.find(sum - target) != prefixSum.end() && prefixSum[sum - target] >= lastEnd) {
                count++;
                lastEnd = i;
            }
            prefixSum[sum] = i;
        }

        return count;
    }
};