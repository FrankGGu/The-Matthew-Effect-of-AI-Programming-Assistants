#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxCostSubstring(string s, vector<int>& cost) {
        int n = s.length();
        unordered_map<char, int> charCost;
        for (int i = 0; i < 26; ++i) {
            charCost['a' + i] = 0;
        }

        for (int i = 0; i < n; ++i) {
            charCost[s[i]] += cost[i];
        }

        int maxCost = 0;
        int currentCost = 0;
        for (int i = 0; i < n; ++i) {
            if (i > 0 && s[i] == s[i - 1]) {
                currentCost += charCost[s[i]];
            } else {
                currentCost = charCost[s[i]];
            }
            maxCost = max(maxCost, currentCost);
        }

        return maxCost;
    }
};