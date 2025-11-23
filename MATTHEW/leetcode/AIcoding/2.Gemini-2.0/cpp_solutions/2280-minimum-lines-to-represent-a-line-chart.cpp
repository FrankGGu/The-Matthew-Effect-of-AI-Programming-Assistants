#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumLines(vector<vector<int>>& stockPrices) {
        if (stockPrices.size() <= 1) return 0;

        sort(stockPrices.begin(), stockPrices.end());

        int lines = 1;
        for (int i = 2; i < stockPrices.size(); ++i) {
            long long x1 = stockPrices[i - 2][0], y1 = stockPrices[i - 2][1];
            long long x2 = stockPrices[i - 1][0], y2 = stockPrices[i - 1][1];
            long long x3 = stockPrices[i][0], y3 = stockPrices[i][1];

            if ((y2 - y1) * (x3 - x2) != (y3 - y2) * (x2 - x1)) {
                lines++;
            }
        }

        return lines;
    }
};