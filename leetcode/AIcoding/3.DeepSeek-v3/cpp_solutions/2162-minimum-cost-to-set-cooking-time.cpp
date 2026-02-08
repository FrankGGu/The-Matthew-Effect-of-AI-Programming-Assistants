class Solution {
public:
    int minCostSetTime(int startAt, int moveCost, int pushCost, int targetSeconds) {
        int minCost = INT_MAX;
        for (int m = 0; m <= 99; ++m) {
            for (int s = 0; s <= 99; ++s) {
                if (m * 60 + s == targetSeconds) {
                    string timeStr = to_string(m * 100 + s);
                    int cost = 0;
                    char current = '0' + startAt;
                    for (char c : timeStr) {
                        if (c != current) {
                            cost += moveCost;
                            current = c;
                        }
                        cost += pushCost;
                    }
                    minCost = min(minCost, cost);
                }
            }
        }
        return minCost;
    }
};