class Solution {
public:
    int countInterestingSubarrays(vector<int>& nums, int modulo, int k) {
        int n = nums.size();
        unordered_map<int, int> count;
        count[0] = 1;
        int prefixSum = 0, interestingCount = 0;

        for (int i = 0; i < n; i++) {
            prefixSum += (nums[i] % modulo == k) ? 1 : 0;
            interestingCount += count[(prefixSum - 1 + modulo) % modulo];
            count[prefixSum % modulo]++;
        }

        return interestingCount;
    }
};