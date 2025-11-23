#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    long long maxAmountAfterTwoDays(long long amount, vector<vector<int>>& conversions) {
        map<int, long long> rate1;
        map<int, long long> rate2;

        for (auto& conv : conversions) {
            int from = conv[0];
            int to = conv[1];
            long long value = conv[2];
            if (rate1.find(from) == rate1.end()) {
                rate1[from] = 0;
            }
            rate1[from] += value;
            if (rate2.find(to) == rate2.end()) {
                rate2[to] = 0;
            }
            rate2[to] += value;
        }

        long long maxAmount = 0;

        for (auto& [from, val1] : rate1) {
            if (rate2.find(from) != rate2.end()) {
                long long total = amount * val1 * rate2[from];
                if (total > maxAmount) {
                    maxAmount = total;
                }
            }
        }

        return maxAmount;
    }
};