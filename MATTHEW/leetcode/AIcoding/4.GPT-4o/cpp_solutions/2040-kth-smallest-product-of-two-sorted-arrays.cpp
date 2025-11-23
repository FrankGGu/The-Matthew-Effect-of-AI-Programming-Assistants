class Solution {
public:
    int kthSmallestProduct(vector<int>& nums1, vector<int>& nums2, int k) {
        long left = 1, right = 1e10;
        for (int num : nums1) left = min(left, (long)num);
        for (int num : nums2) left = min(left, (long)num);

        while (left < right) {
            long mid = left + (right - left) / 2;
            if (countLessEqual(nums1, nums2, mid) < k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    int countLessEqual(vector<int>& nums1, vector<int>& nums2, long mid) {
        int count = 0;
        for (int num : nums1) {
            if (num > 0) {
                count += upper_bound(nums2.begin(), nums2.end(), mid / num) - nums2.begin();
            } else if (num == 0) {
                count += (mid >= 0) * nums2.size();
            } else {
                count += (mid >= 0) * nums2.size();
            }
        }
        return count;
    }
};