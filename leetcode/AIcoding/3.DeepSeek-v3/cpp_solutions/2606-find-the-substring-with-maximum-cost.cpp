class Solution {
public:
    int maximumCostSubstring(string s, string chars, vector<int>& vals) {
        unordered_map<char, int> valueMap;
        for (int i = 0; i < chars.size(); ++i) {
            valueMap[chars[i]] = vals[i];
        }

        int maxCost = 0;
        int currentCost = 0;

        for (char c : s) {
            int cost = (valueMap.find(c) != valueMap.end()) ? valueMap[c] : (c - 'a' + 1);
            currentCost = max(cost, currentCost + cost);
            maxCost = max(maxCost, currentCost);
        }

        return maxCost;
    }
};