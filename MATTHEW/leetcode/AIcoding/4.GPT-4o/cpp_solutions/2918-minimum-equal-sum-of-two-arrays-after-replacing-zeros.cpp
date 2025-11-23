class Solution {
public:
    int minEqualSum(vector<int>& nums1, vector<int>& nums2) {
        int sum1 = accumulate(nums1.begin(), nums1.end(), 0);
        int sum2 = accumulate(nums2.begin(), nums2.end(), 0);
        int zeroCount1 = count(nums1.begin(), nums1.end(), 0);
        int zeroCount2 = count(nums2.begin(), nums2.end(), 0);

        int minSum = min(sum1, sum2);
        int maxSum = max(sum1, sum2);

        int diff = maxSum - minSum;

        if (diff <= 0) return minSum;
        if (zeroCount1 + zeroCount2 < diff) return -1;

        return minSum + diff;
    }
};