class Solution {
public:
    int minSwap(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        int swap = 1, no_swap = 0;

        for (int i = 1; i < n; ++i) {
            int new_swap = n, new_no_swap = n;

            if (nums1[i] > nums1[i-1] && nums2[i] > nums2[i-1]) {
                new_swap = swap + 1;
                new_no_swap = no_swap;
            }
            if (nums1[i] > nums2[i-1] && nums2[i] > nums1[i-1]) {
                new_swap = min(new_swap, no_swap + 1);
                new_no_swap = min(new_no_swap, swap);
            }

            swap = new_swap;
            no_swap = new_no_swap;
        }

        return min(swap, no_swap);
    }
};