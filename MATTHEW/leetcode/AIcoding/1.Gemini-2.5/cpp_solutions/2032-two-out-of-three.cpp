#include <vector>
#include <set>
#include <numeric>

class Solution {
public:
    std::vector<int> twoOutOfThree(std::vector<int>& nums1, std::vector<int>& nums2, std::vector<int>& nums3) {
        std::set<int> s1(nums1.begin(), nums1.end());
        std::set<int> s2(nums2.begin(), nums2.end());
        std::set<int> s3(nums3.begin(), nums3.end());

        std::vector<int> count(101, 0);

        for (int num : s1) {
            count[num]++;
        }
        for (int num : s2) {
            count[num]++;
        }
        for (int num : s3) {
            count[num]++;
        }

        std::vector<int> result;
        for (int i = 1; i <= 100; ++i) {
            if (count[i] >= 2) {
                result.push_back(i);
            }
        }

        return result;
    }
};