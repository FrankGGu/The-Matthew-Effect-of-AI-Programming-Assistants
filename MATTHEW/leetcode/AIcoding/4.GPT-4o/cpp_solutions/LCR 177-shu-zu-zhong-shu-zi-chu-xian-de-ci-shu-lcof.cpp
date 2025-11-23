class Solution {
public:
    int minCost(vector<int>& colors, vector<int>& neededTime) {
        int totalCost = 0, maxTime = 0;
        for (int i = 0; i < colors.size(); ++i) {
            if (i > 0 && colors[i] == colors[i - 1]) {
                totalCost += min(maxTime, neededTime[i]);
                maxTime = max(maxTime, neededTime[i]);
            } else {
                maxTime = neededTime[i];
            }
        }
        return totalCost;
    }
};