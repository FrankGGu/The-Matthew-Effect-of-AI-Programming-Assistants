#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minSwap(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        vector<int> swapdp(n, 0);
        vector<int> noswapdp(n, 0);

        swapdp[0] = 1;
        noswapdp[0] = 0;

        for (int i = 1; i < n; ++i) {
            if (nums1[i] > nums1[i - 1] && nums2[i] > nums2[i - 1]) {
                swapdp[i] = swapdp[i - 1] + 1;
                noswapdp[i] = noswapdp[i - 1];
            } else if (nums1[i] > nums2[i - 1] && nums2[i] > nums1[i - 1]) {
                swapdp[i] = min(swapdp[i - 1], noswapdp[i - 1]) + 1;
                noswapdp[i] = min(swapdp[i - 1], noswapdp[i - 1]);
            } else {
                if (nums1[i] > nums1[i - 1]) {
                    swapdp[i] = swapdp[i - 1] + 1;
                    noswapdp[i] = noswapdp[i - 1];
                } else {
                    swapdp[i] = noswapdp[i - 1] + 1;
                    noswapdp[i] = swapdp[i - 1];
                }
            }
        }

        return min(swapdp[n - 1], noswapdp[n - 1]);
    }
};