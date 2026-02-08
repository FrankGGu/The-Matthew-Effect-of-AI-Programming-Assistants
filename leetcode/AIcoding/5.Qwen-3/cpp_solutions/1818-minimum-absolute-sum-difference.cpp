#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int minAbsoluteSumDiff(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        vector<int> sortedNums1 = nums1;
        sort(sortedNums1.begin(), sortedNums1.end());

        int minAbsDiff = INT_MAX;
        int totalSumDiff = 0;

        for (int i = 0; i < n; ++i) {
            totalSumDiff += abs(nums1[i] - nums2[i]);
        }

        for (int i = 0; i < n; ++i) {
            int target = nums2[i];
            int left = 0, right = n - 1;
            int best = nums1[i];

            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (sortedNums1[mid] == target) {
                    best = target;
                    break;
                } else if (sortedNums1[mid] < target) {
                    left = mid + 1;
                    best = sortedNums1[mid];
                } else {
                    right = mid - 1;
                    best = sortedNums1[mid];
                }
            }

            int currentDiff = abs(nums1[i] - nums2[i]);
            int newDiff = abs(best - nums2[i]);
            minAbsDiff = min(minAbsDiff, currentDiff - newDiff);
        }

        return totalSumDiff - minAbsDiff;
    }
};