class Solution {
public:
    int countSubarrays(vector<int>& nums, int K) {
        int count = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            int currentAnd = nums[i];
            if (currentAnd == K) count++;
            for (int j = i + 1; j < n; ++j) {
                currentAnd &= nums[j];
                if (currentAnd == K) count++;
                if (currentAnd < K) break;
            }
        }
        return count;
    }
};