#include <vector>
#include <numeric>
#include <algorithm>

struct StoneInfo {
    int aliceVal;
    int bobVal;
    int sumVal;
};

bool compareStoneInfo(const StoneInfo& a, const StoneInfo& b) {
    return a.sumVal > b.sumVal;
}

class Solution {
public:
    int stoneGameVI(std::vector<int>& aliceValues, std::vector<int>& bobValues) {
        int n = aliceValues.size();
        std::vector<StoneInfo> stones(n);

        for (int i = 0; i < n; ++i) {
            stones[i].aliceVal = aliceValues[i];
            stones[i].bobVal = bobValues[i];
            stones[i].sumVal = aliceValues[i] + bobValues[i];
        }

        std::sort(stones.begin(), stones.end(), compareStoneInfo);

        long long aliceScore = 0;
        long long bobScore = 0;

        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                aliceScore += stones[i].aliceVal;
            } else {
                bobScore += stones[i].bobVal;
            }
        }

        if (aliceScore > bobScore) {
            return 1;
        } else {
            return -1;
        }
    }
};