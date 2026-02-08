#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumsSplicedArray(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        int sum1 = accumulate(nums1.begin(), nums1.end(), 0);
        int sum2 = accumulate(nums2.begin(), nums2.end(), 0);

        int diff1[n];
        int diff2[n];

        for (int i = 0; i < n; ++i) {
            diff1[i] = nums2[i] - nums1[i];
            diff2[i] = nums1[i] - nums2[i];
        }

        int max_so_far1 = 0, current_max1 = 0;
        for (int i = 0; i < n; i++) {
            current_max1 += diff1[i];
            if (current_max1 < 0)
                current_max1 = 0;
            max_so_far1 = max(max_so_far1, current_max1);
        }

        int max_so_far2 = 0, current_max2 = 0;
        for (int i = 0; i < n; i++) {
            current_max2 += diff2[i];
            if (current_max2 < 0)
                current_max2 = 0;
            max_so_far2 = max(max_so_far2, current_max2);
        }

        return max(sum1 + max_so_far1, sum2 + max_so_far2);
    }
};