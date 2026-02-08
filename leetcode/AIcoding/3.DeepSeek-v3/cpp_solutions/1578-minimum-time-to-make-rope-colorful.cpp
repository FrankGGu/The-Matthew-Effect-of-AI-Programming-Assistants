class Solution {
public:
    int minCost(string colors, vector<int>& neededTime) {
        int totalTime = 0;
        int maxTime = neededTime[0];
        int sumTime = neededTime[0];
        int n = colors.size();

        for (int i = 1; i < n; ++i) {
            if (colors[i] != colors[i-1]) {
                totalTime += sumTime - maxTime;
                maxTime = neededTime[i];
                sumTime = neededTime[i];
            } else {
                sumTime += neededTime[i];
                maxTime = max(maxTime, neededTime[i]);
            }
        }
        totalTime += sumTime - maxTime;

        return totalTime;
    }
};