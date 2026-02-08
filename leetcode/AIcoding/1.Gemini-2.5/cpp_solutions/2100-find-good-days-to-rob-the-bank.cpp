#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> goodDaysToRobBank(std::vector<int>& security, int time) {
        int n = security.size();
        std::vector<int> left(n);
        std::vector<int> right(n);

        if (n == 0) {
            return {};
        }

        left[0] = 1;
        for (int i = 1; i < n; ++i) {
            if (security[i - 1] >= security[i]) {
                left[i] = left[i - 1] + 1;
            } else {
                left[i] = 1;
            }
        }

        right[n - 1] = 1;
        for (int i = n - 2; i >= 0; --i) {
            if (security[i] <= security[i + 1]) {
                right[i] = right[i + 1] + 1;
            } else {
                right[i] = 1;
            }
        }

        std::vector<int> result;
        for (int i = time; i < n - time; ++i) {
            if (left[i] >= time + 1 && right[i] >= time + 1) {
                result.push_back(i);
            }
        }

        return result;
    }
};