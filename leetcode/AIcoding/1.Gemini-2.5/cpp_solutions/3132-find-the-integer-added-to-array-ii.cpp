#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimumAddedInteger(std::vector<int>& nums1, std::vector<int>& nums2) {
        std::sort(nums1.begin(), nums1.end());
        std::sort(nums2.begin(), nums2.end());

        int min_x = INT_MAX;
        int n = nums1.size();

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                std::vector<int> temp;
                for (int k = 0; k < n; ++k) {
                    if (k != i && k != j) {
                        temp.push_back(nums1[k]);
                    }
                }

                int diff = nums2[0] - temp[0];
                bool possible = true;
                for (size_t k = 1; k < temp.size(); ++k) {
                    if (nums2[k] - temp[k] != diff) {
                        possible = false;
                        break;
                    }
                }

                if (possible) {
                    min_x = std::min(min_x, diff);
                }
            }
        }

        return min_x;
    }
};