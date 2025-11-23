#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    int minNumber(std::vector<int>& nums1, std::vector<int>& nums2) {
        int min1 = 10;
        for (int num : nums1) {
            min1 = std::min(min1, num);
        }

        int min2 = 10;
        for (int num : nums2) {
            min2 = std::min(min2, num);
        }

        int smallestCommonDigit = 10;
        std::set<int> set1(nums1.begin(), nums1.end());
        for (int num : nums2) {
            if (set1.count(num)) {
                smallestCommonDigit = std::min(smallestCommonDigit, num);
            }
        }

        int twoDigitNumber = std::min(min1, min2) * 10 + std::max(min1, min2);

        if (smallestCommonDigit != 10) {
            return std::min(smallestCommonDigit, twoDigitNumber);
        } else {
            return twoDigitNumber;
        }
    }
};