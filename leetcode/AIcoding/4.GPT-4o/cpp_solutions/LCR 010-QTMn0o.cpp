class Solution {
public:
    int subarraySum(vector<int>& nums, int k) {
        unordered_map<int, int> prefixSumCount;
        prefixSumCount[0] = 1;
        int count = 0, currentSum = 0;

        for (int num : nums) {
            currentSum += num;
            count += prefixSumCount[currentSum - k];
            prefixSumCount[currentSum]++;
        }

        return count;
    }
};