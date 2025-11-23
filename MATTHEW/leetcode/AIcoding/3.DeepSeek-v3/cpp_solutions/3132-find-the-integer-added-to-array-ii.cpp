class Solution {
public:
    int addedInteger(vector<int>& nums1, vector<int>& nums2) {
        sort(nums1.begin(), nums1.end());
        sort(nums2.begin(), nums2.end());
        int n = nums1.size();
        int candidate1 = nums2[0] - nums1[0];
        int candidate2 = nums2[n-1] - nums1[n-1];
        if (candidate1 == candidate2) {
            return candidate1;
        }
        int candidate3 = nums2[1] - nums1[1];
        if (candidate1 == candidate3) {
            return candidate1;
        } else {
            return candidate2;
        }
    }
};