#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<bool> checkArithmeticSubarrays(std::vector<int>& nums, std::vector<int>& l, std::vector<int>& r) {
        int m = l.size();
        std::vector<bool> result;
        result.reserve(m);

        for (int i = 0; i < m; ++i) {
            int start = l[i];
            int end = r[i];

            if (end - start + 1 < 2) {
                result.push_back(false);
                continue;
            }

            std::vector<int> subarray;
            subarray.reserve(end - start + 1);
            for (int j = start; j <= end; ++j) {
                subarray.push_back(nums[j]);
            }

            std::sort(subarray.begin(), subarray.end());

            int diff = subarray[1] - subarray[0];
            bool is_arithmetic = true;
            for (int k = 2; k < subarray.size(); ++k) {
                if (subarray[k] - subarray[k-1] != diff) {
                    is_arithmetic = false;
                    break;
                }
            }
            result.push_back(is_arithmetic);
        }

        return result;
    }
};