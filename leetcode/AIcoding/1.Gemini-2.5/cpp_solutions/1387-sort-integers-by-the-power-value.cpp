#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    int getKth(int lo, int hi, int k) {
        static std::map<int, int> powerMemo;

        auto calculatePowerValue = [&](int n) -> int {
            if (n == 1) {
                return 0;
            }
            if (powerMemo.count(n)) {
                return powerMemo[n];
            }

            int steps;
            if (n % 2 == 0) {
                steps = 1 + calculatePowerValue(n / 2);
            } else {
                steps = 1 + calculatePowerValue(3 * n + 1);
            }
            return powerMemo[n] = steps;
        };

        std::vector<std::pair<int, int>> numbersWithPower;
        for (int i = lo; i <= hi; ++i) {
            numbersWithPower.push_back({calculatePowerValue(i), i});
        }

        std::sort(numbersWithPower.begin(), numbersWithPower.end());

        return numbersWithPower[k - 1].second;
    }
};