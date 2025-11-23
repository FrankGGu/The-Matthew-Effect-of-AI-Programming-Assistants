class Solution {
public:
    int maximumCostSubstring(string s, vector<int>& cost) {
        int maxCost = 0, currentCost = 0;
        for (char c : s) {
            int charCost = cost[c - 'a'];
            currentCost += charCost;
            if (currentCost < 0) {
                currentCost = 0;
            }
            maxCost = max(maxCost, currentCost);
        }
        return maxCost;
    }
};