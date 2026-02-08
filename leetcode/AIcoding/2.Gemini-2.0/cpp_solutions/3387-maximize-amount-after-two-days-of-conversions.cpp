#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximizeAmount(int amount, vector<vector<int>>& conversions) {
        long long max_amount = amount;

        for (auto& conversion : conversions) {
            if (conversion[0] == 0) {
                max_amount = max(max_amount, (long long)conversion[1]);
            }
        }

        for (auto& conversion1 : conversions) {
            if (conversion1[0] == 1) {
                long long amount1 = max_amount * conversion1[1];
                max_amount = max(max_amount, amount1);
            }
        }

        return max_amount;
    }
};