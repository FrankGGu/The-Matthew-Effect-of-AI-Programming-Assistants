#include <iostream>
#include <vector>
#include <unordered_set>

class Solution {
public:
    std::vector<int> findCommonElements(std::vector<int>& nums1, std::vector<int>& nums2) {
        std::unordered_set<int> set1(nums1.begin(), nums1.end());
        std::vector<int> result;
        for (int num : nums2) {
            if (set1.find(num) != set1.end()) {
                result.push_back(num);
            }
        }
        return result;
    }
};