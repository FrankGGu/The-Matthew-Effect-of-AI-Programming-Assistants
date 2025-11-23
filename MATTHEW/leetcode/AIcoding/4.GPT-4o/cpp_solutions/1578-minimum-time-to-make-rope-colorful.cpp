class Solution {
public:
    int minCost(string colors, vector<int>& neededTime) {
        int totalCost = 0, maxCost = 0;
        for (int i = 0; i < colors.size(); ++i) {
            if (i > 0 && colors[i] == colors[i - 1]) {
                totalCost += min(maxCost, neededTime[i]);
                maxCost = max(maxCost, neededTime[i]);
            } else {
                maxCost = neededTime[i];
            }
        }
        return totalCost;
    }
};