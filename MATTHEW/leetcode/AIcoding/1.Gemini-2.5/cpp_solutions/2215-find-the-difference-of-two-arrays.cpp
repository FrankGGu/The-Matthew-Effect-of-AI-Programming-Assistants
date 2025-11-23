#include <vector>
#include <unordered_set>

class Solution {
public:
    std::vector<std::vector<int>> findDifference(std::vector<int>& nums1, std::vector<int>& nums2) {
        std::unordered_set<int> set1(nums1.begin(), nums1.end());
        std::unordered_set<int> set2(nums2.begin(), nums2.end());

        std::vector<int> diff1;
        for (const int& num : set1) {
            if (set2.count(num) == 0) {
                diff1.push_back(num);
            }
        }

        std::vector<int> diff2;
        for (const int& num : set2) {
            if (set1.count(num) == 0) {
                diff2.push_back(num);
            }
        }

        return {diff1, diff2};
    }
};