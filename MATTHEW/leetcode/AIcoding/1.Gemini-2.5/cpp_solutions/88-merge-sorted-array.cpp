class Solution {
public:
    void merge(std::vector<int>& nums1, int m, std::vector<int>& nums2, int n) {
        int p1 = m - 1;
        int p2 = n - 1;
        int p_write = m + n - 1;

        while (p2 >= 0) {
            if (p1 >= 0 && nums1[p1] > nums2[p2]) {
                nums1[p_write] = nums1[p1];
                p1--;
            } else {
                nums1[p_write] = nums2[p2];
                p2--;
            }
            p_write--;
        }
    }
};