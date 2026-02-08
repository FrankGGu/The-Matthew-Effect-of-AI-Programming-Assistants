#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumSplicedScore(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        int sum1 = 0, sum2 = 0;
        for (int i = 0; i < n; ++i) {
            sum1 += nums1[i];
            sum2 += nums2[i];
        }

        vector<int> diff1(n), diff2(n);
        for (int i = 0; i < n; ++i) {
            diff1[i] = nums1[i] - nums2[i];
            diff2[i] = nums2[i] - nums1[i];
        }

        int maxDiff1 = 0, current = 0;
        for (int i = 0; i < n; ++i) {
            current = max(diff1[i], current + diff1[i]);
            maxDiff1 = max(maxDiff1, current);
        }

        int maxDiff2 = 0, current2 = 0;
        for (int i = 0; i < n; ++i) {
            current2 = max(diff2[i], current2 + diff2[i]);
            maxDiff2 = max(maxDiff2, current2);
        }

        return max(sum1 + maxDiff1, sum2 + maxDiff2);
    }
};