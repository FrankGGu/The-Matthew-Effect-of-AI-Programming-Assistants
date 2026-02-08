#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums1, vector<int>& nums2) {
        int sum1 = 0, sum2 = 0;
        for (int num : nums1) sum1 += num;
        for (int num : nums2) sum2 += num;

        if (sum1 > sum2) {
            swap(nums1, nums2);
            swap(sum1, sum2);
        }

        if (sum2 > sum1 + 5LL * nums1.size()) return -1;

        sort(nums1.begin(), nums1.end());
        sort(nums2.begin(), nums2.end(), greater<int>());

        int i = 0, j = 0, ops = 0;
        while (sum1 < sum2) {
            if (i < nums1.size() && (j == nums2.size() || 6 - nums1[i] >= nums2[j] - 1)) {
                sum1 += 6 - nums1[i];
                i++;
            } else {
                sum1 += nums2[j] - 1;
                j++;
            }
            ops++;
        }

        return ops;
    }
};