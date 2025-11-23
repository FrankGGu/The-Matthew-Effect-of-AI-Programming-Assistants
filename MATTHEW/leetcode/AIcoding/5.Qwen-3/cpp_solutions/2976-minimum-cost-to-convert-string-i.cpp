#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minCost(string str1, string str2, vector<int>& cost) {
        unordered_map<char, int> charCost;
        for (int i = 0; i < 26; ++i) {
            charCost['a' + i] = cost[i];
        }

        int n = str1.length();
        int res = 0;

        for (int i = 0; i < n; ++i) {
            if (str1[i] != str2[i]) {
                res += charCost[str1[i]];
            }
        }

        return res;
    }
};