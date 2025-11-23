class Solution {
public:
    long long countSubarrays(vector<int>& nums, int minK, int maxK) {
        long long result = 0;
        int left = 0, lastInvalid = -1, lastMin = -1, lastMax = -1;

        for (int i = 0; i < nums.size(); i++) {
            if (nums[i] < minK || nums[i] > maxK) {
                left = i + 1;
                lastInvalid = i;
            }
            if (nums[i] == minK) lastMin = i;
            if (nums[i] == maxK) lastMax = i;

            result += max(0, min(lastMin, lastMax) - left + 1);
        }

        return result;
    }
};