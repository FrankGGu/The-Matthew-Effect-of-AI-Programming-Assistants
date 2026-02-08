class Solution {
public:
    int minAbsoluteSumDiff(vector<int>& nums1, vector<int>& nums2) {
        const int MOD = 1e9 + 7;
        long long totalDiff = 0;
        int n = nums1.size();
        vector<int> sortedNums1 = nums1;
        sort(sortedNums1.begin(), sortedNums1.end());
        long long maxGain = 0;

        for (int i = 0; i < n; i++) {
            totalDiff = (totalDiff + abs(nums1[i] - nums2[i])) % MOD;
            int target = nums2[i];
            auto it = lower_bound(sortedNums1.begin(), sortedNums1.end(), target);
            if (it != sortedNums1.end()) {
                maxGain = max(maxGain, (long long)abs(nums1[i] - *it) - abs(target - *it));
            }
            if (it != sortedNums1.begin()) {
                --it;
                maxGain = max(maxGain, (long long)abs(nums1[i] - *it) - abs(target - *it));
            }
        }

        return (totalDiff - maxGain + MOD) % MOD;
    }
};