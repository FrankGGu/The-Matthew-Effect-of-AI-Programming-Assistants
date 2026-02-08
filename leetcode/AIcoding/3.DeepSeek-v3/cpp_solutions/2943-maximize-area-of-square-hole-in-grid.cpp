#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maximizeSquareHoleArea(int n, int m, vector<int>& hBars, vector<int>& vBars) {
        int maxH = maxConsecutive(hBars);
        int maxV = maxConsecutive(vBars);
        int side = min(maxH, maxV) + 1;
        return side * side;
    }

private:
    int maxConsecutive(vector<int>& bars) {
        sort(bars.begin(), bars.end());
        int maxLen = 1;
        int current = 1;
        for (int i = 1; i < bars.size(); ++i) {
            if (bars[i] == bars[i-1] + 1) {
                current++;
                maxLen = max(maxLen, current);
            } else {
                current = 1;
            }
        }
        return maxLen;
    }
};