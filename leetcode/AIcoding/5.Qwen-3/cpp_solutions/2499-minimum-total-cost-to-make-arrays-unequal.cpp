#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumTotalCost(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        long long totalCost = 0;
        int sameCount = 0;
        int diffCount = 0;

        for (int i = 0; i < n; ++i) {
            if (nums1[i] == nums2[i]) {
                sameCount++;
            } else {
                diffCount++;
            }
        }

        if (sameCount == 0) {
            return 0;
        }

        int minSwaps = min(sameCount, diffCount);
        totalCost = static_cast<long long>(minSwaps) * 2;

        return totalCost;
    }
};