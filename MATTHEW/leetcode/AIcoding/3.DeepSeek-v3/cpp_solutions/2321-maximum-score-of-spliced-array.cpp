class Solution {
public:
    int maximumsSplicedArray(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        int sum1 = accumulate(nums1.begin(), nums1.end(), 0);
        int sum2 = accumulate(nums2.begin(), nums2.end(), 0);

        int max1 = 0, max2 = 0;
        int curr1 = 0, curr2 = 0;

        for (int i = 0; i < n; ++i) {
            int diff = nums2[i] - nums1[i];
            curr1 += diff;
            curr2 -= diff;

            if (curr1 < 0) curr1 = 0;
            if (curr2 < 0) curr2 = 0;

            max1 = max(max1, curr1);
            max2 = max(max2, curr2);
        }

        return max(sum1 + max1, sum2 + max2);
    }
};