class Solution {
public:
    int maxDistance(vector<int>& nums1, vector<int>& nums2) {
        int maxDist = 0;
        int i = 0, j = 0;
        int m = nums1.size(), n = nums2.size();

        while (i < m && j < n) {
            if (nums1[i] > nums2[j]) {
                i++;
            } else {
                maxDist = max(maxDist, j - i);
                j++;
            }
        }

        return maxDist;
    }
};