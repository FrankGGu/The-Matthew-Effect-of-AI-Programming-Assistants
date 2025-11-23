#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<long long> maximumEvenSplit(long long finalSum) {
        if (finalSum % 2 != 0) {
            return {};
        }

        std::vector<long long> ans;
        long long current_even = 2;

        while (finalSum >= current_even) {
            ans.push_back(current_even);
            finalSum -= current_even;
            current_even += 2;
        }

        if (finalSum > 0) {
            ans.back() += finalSum;
        }

        return ans;
    }
};