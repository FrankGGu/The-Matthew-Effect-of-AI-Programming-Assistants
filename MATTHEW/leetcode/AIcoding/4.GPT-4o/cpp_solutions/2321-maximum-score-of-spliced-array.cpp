class Solution {
public:
    int maximumScore(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        long long totalSum1 = accumulate(nums1.begin(), nums1.end(), 0LL);
        long long totalSum2 = accumulate(nums2.begin(), nums2.end(), 0LL);

        long long maxScore = totalSum1 + totalSum2;

        for (int i = 0; i < n; ++i) {
            long long currentScore = totalSum1 - nums1[i] + nums2[i];
            maxScore = max(maxScore, currentScore);
        }

        for (int i = 0; i < n; ++i) {
            long long currentScore = totalSum2 - nums2[i] + nums1[i];
            maxScore = max(maxScore, currentScore);
        }

        return maxScore;
    }
};