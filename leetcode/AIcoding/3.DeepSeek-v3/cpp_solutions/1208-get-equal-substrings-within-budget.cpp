class Solution {
public:
    int equalSubstring(string s, string t, int maxCost) {
        int n = s.size();
        vector<int> cost(n);
        for (int i = 0; i < n; ++i) {
            cost[i] = abs(s[i] - t[i]);
        }
        int left = 0, currentCost = 0, maxLen = 0;
        for (int right = 0; right < n; ++right) {
            currentCost += cost[right];
            while (currentCost > maxCost) {
                currentCost -= cost[left];
                left++;
            }
            maxLen = max(maxLen, right - left + 1);
        }
        return maxLen;
    }
};