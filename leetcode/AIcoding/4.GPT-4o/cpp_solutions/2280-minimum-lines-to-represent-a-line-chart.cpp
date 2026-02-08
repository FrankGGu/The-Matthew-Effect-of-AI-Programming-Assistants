#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumLines(vector<vector<int>>& stockPrices) {
        if (stockPrices.size() < 2) return 0;

        sort(stockPrices.begin(), stockPrices.end());
        int lines = 0;

        long long prevX = stockPrices[0][0], prevY = stockPrices[0][1];
        for (int i = 1; i < stockPrices.size(); ++i) {
            long long currX = stockPrices[i][0], currY = stockPrices[i][1];
            if (lines == 0 || (currY - prevY) * (currX - prevX) != (currY - stockPrices[i - 1][1]) * (currX - stockPrices[i - 1][0])) {
                lines++;
            }
            prevX = currX;
            prevY = currY;
        }

        return lines;
    }
};