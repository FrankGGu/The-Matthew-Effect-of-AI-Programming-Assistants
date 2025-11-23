#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    std::vector<int> intersection(std::vector<int>& nums1, std::vector<int>& nums2) {
        std::unordered_set<int> set1(nums1.begin(), nums1.end());
        std::vector<int> result;

        for (int num : nums2) {
            if (set1.count(num)) {
                result.push_back(num);
                set1.erase(num); // Remove to ensure uniqueness in the result
            }
        }

        return result;
    }
};