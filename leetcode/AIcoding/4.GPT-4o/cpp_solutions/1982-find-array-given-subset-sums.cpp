#include <vector>
#include <numeric>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    std::vector<int> findArray(std::vector<int>& sums) {
        int n = sums.size();
        std::vector<int> result(n - 1);
        std::unordered_set<int> seen;

        for (int i = 0; i < n - 1; ++i) {
            int x = sums[i + 1] - (i > 0 ? sums[i] : 0);
            result[i] = x;
            seen.insert(x);
        }

        if (seen.size() != n - 1) return {};

        return result;
    }
};