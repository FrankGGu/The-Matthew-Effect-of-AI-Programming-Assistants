class Solution {
public:
    int xorAllNums(vector<int>& nums1, vector<int>& nums2) {
        int m = nums1.size();
        int n = nums2.size();
        int res = 0;

        if (n % 2 == 1) {
            for (int num : nums1) {
                res ^= num;
            }
        }

        if (m % 2 == 1) {
            for (int num : nums2) {
                res ^= num;
            }
        }

        return res;
    }
};