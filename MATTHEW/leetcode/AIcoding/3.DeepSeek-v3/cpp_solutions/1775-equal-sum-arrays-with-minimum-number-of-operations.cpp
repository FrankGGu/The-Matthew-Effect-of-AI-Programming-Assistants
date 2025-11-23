class Solution {
public:
    int minOperations(vector<int>& nums1, vector<int>& nums2) {
        int sum1 = accumulate(nums1.begin(), nums1.end(), 0);
        int sum2 = accumulate(nums2.begin(), nums2.end(), 0);
        if (sum1 == sum2) return 0;
        if (sum1 < sum2) return minOperations(nums2, nums1);

        sort(nums1.begin(), nums1.end());
        sort(nums2.begin(), nums2.end());

        int diff = sum1 - sum2;
        int i = nums1.size() - 1;
        int j = 0;
        int res = 0;

        while (diff > 0 && (i >= 0 || j < nums2.size())) {
            int change1 = i >= 0 ? nums1[i] - 1 : 0;
            int change2 = j < nums2.size() ? 6 - nums2[j] : 0;

            if (change1 >= change2) {
                diff -= min(diff, change1);
                i--;
            } else {
                diff -= min(diff, change2);
                j++;
            }
            res++;
        }

        return diff == 0 ? res : -1;
    }
};